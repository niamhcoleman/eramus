from flask import Flask
from food_diary import food_diary
from api_sample import api_sample
from API_Symptom_Tracker import API_Symptom_Tracker
from flask_cors import CORS
from database_manager import DatabaseManager

app = Flask(__name__)
app.secret_key = '_5#y2L"F4Qdkslppwkwn8z\ndkdn\xec]/'
CORS(app)

app.database_manager = DatabaseManager()

app.register_blueprint(food_diary)
app.register_blueprint(api_sample)
app.register_blueprint(API_Symptom_Tracker)


app.run(host='0.0.0.0', debug=True, use_reloader=True)

