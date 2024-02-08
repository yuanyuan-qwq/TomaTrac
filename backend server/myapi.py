from tensorflow.keras.models import load_model
from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from asyncio import Event
import uvicorn
import numpy as np
from io import BytesIO
from PIL import Image
import tensorflow as tf
import nltk
import json
import pickle

from fastapi.responses import FileResponse
import io
import torch
import tempfile

from nltk.stem import WordNetLemmatizer

#file import
#from ChatBot import chatBot


app = FastAPI()

predicted_class = "null"
confidence = 0.0
update_event = Event()

origins = [
    "http://localhost",
    "http://localhost:3000",
]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

###### ALL CNN Model #######
def read_file_as_image(data) -> np.ndarray:
    image = Image.open(BytesIO(data))
    image = image.resize((256, 256))
    image = np.array(image)
    return image

############### CNN Model #################{
CNN_MODEL = tf.keras.models.load_model("CNN\\tomato12v3.h5")

CLASS_NAMES = ['Tomato Bacterial spot',
 'Tomato Early blight',
 'Tomato Late blight',
 'Tomato Leaf Mold',
 'Tomato Septoria leaf_spot',
 'Tomato Twospotted Spider Mites',
 'Tomato Target Spot',
 'Tomato Yellow Leaf Curl Virus',
 'Tomato mosaic virus',
 'Healthy',
 'No Leaf Detected',
 'Not a Tomato Leaf']

############### CNN Model #################}

############### CNN Stage Model #################{v4
CNN_Stage_MODEL = tf.keras.models.load_model("CNNStage\\tomatoStagev5.h5")

CLASS_Stage_NAMES = ['Flowering Stage',
 'Fruit Formation Stage',
 'Germination Stage',
 'Ripening Stage',
 'Vegetative Stage',
 'no tomato plant detected']

############### CNN Model #################}

############### Yolo Model #################{ exp2>exp7>exp5
model = torch.hub.load('ultralytics/yolov5', 'custom', path='D:/Programming/Python/WS2 backend/YOLO1.1/yolov5/runs/train/exp2/weights/last.pt', force_reload=True)
model.eval()
############### Yolo Model #################}

############### ChatBot Model #################{
ChatModel = load_model('ChatBot/chatbot_model.h5')
intents = json.loads(open('ChatBot/intents.json').read())
words = pickle.load(open('ChatBot/words.pkl', 'rb'))
classes = pickle.load(open('ChatBot/classes.pkl', 'rb'))

lemmatizer = WordNetLemmatizer()

def clean_up_sentence(sentence):
    sentence_words = nltk.word_tokenize(sentence)
    sentence_words = [lemmatizer.lemmatize(word.lower()) for word in sentence_words]
    return sentence_words

def bow(sentence, words, show_details=True):
    sentence_words = clean_up_sentence(sentence)
    bag = [0] * len(words)
    for s in sentence_words:
        for i, w in enumerate(words):
            if w == s:
                bag[i] = 1
                if show_details:
                    print("found in bag: %s" % w)
    return np.array(bag)

def predict_class(sentence, ChatModel):
    p = bow(sentence, words, show_details=False)
    res = ChatModel.predict(np.array([p]))[0]
    ERROR_THRESHOLD = 0.25
    results = [[i, r] for i, r in enumerate(res) if r > ERROR_THRESHOLD]
    results.sort(key=lambda x: x[1], reverse=True)
    return_list = [{"intent": classes[r[0]], "probability": str(r[1])} for r in results]
    return return_list

def getResponse(ints, intents_json):
    if ints:
        tag = ints[0]['intent']
        list_of_intents = intents_json['intents']
        for i in list_of_intents:
            if i['tag'] == tag:
                result = np.random.choice(i['responses'])
                break
        return result
    else:
        return "I'm not sure what you're asking for. Can you be more specific?"

############### ChatBot Model #################}

@app.get("/")
async def ping():
    return "Hello, I am yuan"

@app.post("/predict")
async def predict_CNN_Model(
    file: UploadFile = File(...)
):
    global predicted_class, confidence, stage
    image = read_file_as_image(await file.read())
    img_batch = np.expand_dims(image, 0)
    
    predictions = CNN_MODEL.predict(img_batch)
    stage_predictions = CNN_Stage_MODEL.predict(img_batch)

    predicted_class = CLASS_NAMES[np.argmax(predictions[0])]
    confidence = np.max(predictions[0])
    stage = CLASS_Stage_NAMES[np.argmax(stage_predictions[0])]
    stage_confidence = np.max(stage_predictions[0])
    
    # Set the event to signal that the variables have been updated
    update_event.set()

    return {
        'class': predicted_class,
        'confidence': float(confidence),
        'stage' : stage,
        'state_confidence': float(stage_confidence)
    }

@app.post("/detect/")
async def detect_objects(file: UploadFile = File(...)):
    # Read uploaded image file as bytes
    contents = await file.read()

    # Load image from bytes using PIL
    img_pil = Image.open(io.BytesIO(contents))

    # Convert PIL image to OpenCV format
    img = np.array(img_pil)

    # Make detections
    results = model(img)

    # Render detections on the image
    rendered_img = np.squeeze(results.render())

    # Convert image to bytes for displaying
    img_pil_rendered = Image.fromarray(rendered_img)
    buffered = io.BytesIO()
    img_pil_rendered.save(buffered, format="JPEG")
    img_bytes = buffered.getvalue()

    # Save annotated image bytes to a temporary file
    temp_file = tempfile.NamedTemporaryFile(delete=False, suffix='.jpg')
    temp_file.write(img_bytes)
    temp_file.close()

    # Return the temporary file as a FileResponse
    return FileResponse(temp_file.name, media_type="image/jpeg")


@app.post("/chat")
async def chatBot_NLP_Model(text: str):
    ints = predict_class(text, ChatModel)
    res = getResponse(ints, intents)
    return {"response": res}


if __name__ == "__main__":
   uvicorn.run(app, host='192.168.137.1', port=8000)
    
