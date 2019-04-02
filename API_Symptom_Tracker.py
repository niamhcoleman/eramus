import os
from flask import Flask, jsonify, request, send_from_directory, Blueprint
from werkzeug import secure_filename
import requests
import json
from flask_cors import CORS
import mysql.connector
from datetime import datetime

API_Symptom_Tracker = Blueprint('API_Symptom_Tracker', __name__)

# Account Tab - takes in user id - returns name and email associated with ID
@app.route('/account/getuserinfo/<user_id>', methods=['GET'])
def getuserinfo(user_id):
    try:
        connection = config.db_manager.get_connection()
        cursor = connection.cursor()

        query = "SELECT user_name, user_email FROM users WHERE user_id = %s;"
        cursor.execute(query % user_id)
        result = []
        for (user_name, user_email) in cursor:
            result.append({"user_name": user_name, "user_email": user_email})

        connection.close()
        cursor.close()
        return jsonify(result)
    except Exception as e:
        error = "{'error': " + str(e) + "}"
        return error


# Account Tab - takes in new password and user id - returns confirmation/failure of password change.
@app.route('/account/changepassword/<new_password>/<user_id>', methods=['POST'])
def changepassword(new_password, user_id):
    try:
        connection = config.db_manager.get_connection()
        cursor = connection.cursor()
        query = "UPDATE users SET user_password = %s WHERE user_id = %s;"
        cursor.execute(query % (new_password, user_id))
        connection.commit()
        connection.close()
        cursor.close()
        return "{'status': 'success'}"

    except Exception as e:
        error = "{'error': " + str(e) + "}"
        return error

# History Tab
# Returning info from a particular day
@app.route('/history/getdayinfo/<user_id>/<target_date>/', methods = ['GET'])
def getdayinfo(user_id, target_date):
    try:
        connection = config.db_manager.get_connection()
        cursor = connection.cursor()

        query = "SELECT symptom_entry_id FROM entries WHERE user_id = '%s' AND entry_date = '%s' AND entry_tod = '%s';"

        # morning
        cursor.execute(query % (user_id, target_date, 'morning'))
        morning = cursor.fetchall()

        # afternoon
        cursor.execute(query % (user_id, target_date, 'afternoon'))
        afternoon = cursor.fetchall()

        # evening
        cursor.execute(query % (user_id, target_date, 'evening'))
        evening = cursor.fetchall()

        # night
        cursor.execute(query % (user_id, target_date, 'night'))
        night = cursor.fetchall()

        if morning:
            morning_symptom_entry_id = morning[0][0]
            query = "SELECT symptom_entry_sev, sym_id FROM symptomentry WHERE sym_entry_id = '%s';"
            cursor.execute(query % morning_symptom_entry_id)
            result = cursor.fetchall()
            # [[symptom severity, symptom id]]
            # swap symptom id for the symptom name
            x = []
            for entry in result:
                id = entry[1]
                severity = entry[0]
                query = "SELECT sym_name FROM symptoms WHERE sym_id = '%s';"
                cursor.execute(query % id)
                result = cursor.fetchall()
                name = result[0][0]
                x.append([severity, name])
            result_dict['morning'] = x

        if afternoon:
            afternoon_symptom_entry_id = afternoon[0][0]
            query = "SELECT symptom_entry_sev, sym_id FROM symptomentry WHERE sym_entry_id = '%s';"
            cursor.execute(query % afternoon_symptom_entry_id)
            result = cursor.fetchall()
            # [[symptom severity, symptom id]]
            # swap symptom id for the symptom name
            x = []
            for entry in result:
                id = entry[1]
                severity = entry[0]
                query = "SELECT sym_name FROM symptoms WHERE sym_id = '%s';"
                cursor.execute(query % id)
                result = cursor.fetchall()
                name = result[0][0]
                x.append([severity, name])
            result_dict['afternoon'] = x

        if evening:
            evening_symptom_entry_id = evening[0][0]
            query = "SELECT symptom_entry_sev, sym_id FROM symptomentry WHERE sym_entry_id = '%s';"
            cursor.execute(query % (evening_symptom_entry_id))
            result = cursor.fetchall()
            # [[symptom severity, symptom id]]
            # swap symptom id for the symptom name
            x = []
            for entry in result:
                id = entry[1]
                severity = entry[0]
                query = "SELECT sym_name FROM symptoms WHERE sym_id = '%s';"
                cursor.execute(query % id)
                result = cursor.fetchall()
                name = result[0][0]
                x.append([severity, name])
            result_dict['evening'] = x

        if night:
            night_symptom_entry_id = result[0][0]
            query = "SELECT symptom_entry_sev, sym_id FROM symptomentry WHERE sym_entry_id = '%s';"
            cursor.execute(query % (night_symptom_entry_id))
            result = cursor.fetchall()
            #result in the form: [[symptom severity, symptom id]]
            # swap symptom id for the symptom name
            x = []
            for entry in result:
                id = entry[1]
                severity = entry[0]
                query = "SELECT sym_name FROM symptoms WHERE sym_id = '%s';"
                cursor.execute(query % id)
                result = cursor.fetchall()
                name = result[0][0]
                x.append([severity, name])
            result_dict['night'] = x

            # result_dict consists of a dict with format: { "evening": [ [ 2, "acne" ], [ 2, "insomnia" ] ], "morning": [ [ 2, "acne" ] ], "night": [ [ 2, "acne" ], [ 2, "insomnia" ] ] }

        connection.close()
        cursor.close()

        return jsonify(result_dict)
    except Exception as e:
        error = "{'error': " + str(e) + "}"
        return error


#logging symptoms
@app.route('/tracking/logentry', methods = ['POST'])
def logentry():
    try:
        connection = config.db_manager.get_connection()
        cursor = connection.cursor()

        user_id = request.args["user_id"]
        now = datetime.now()
        formatted_date = now.strftime('%Y-%m-%d')
        entry_tod = request.args["entry_tod"]
        entry_emo_id = request.args["entry_emo_id"]
        notes = request.args["notes"]
        symptoms = request.args.getlist('symptoms')

        # symptoms contains a list of strings e.g. [ "acne, 2", "insomnia , 2" ]

        # symptom_entry_id = max id in table + 1
        query = "SELECT MAX(sym_entry_id) AS maximum from symptomentry LIMIT 1;"
        cursor.execute(query)
        result = cursor.fetchall()

        if result[0][0] is None:
            new_sym_entry_id = 0
        else:
            new_sym_entry_id = result[0][0] + 1

        query = "INSERT INTO entries (user_id, entry_date, entry_tod, entry_emo_id, symptom_entry_id, notes) VALUES (%s, %s, %s, %s, %s, %s);"
        cursor.execute(query, (user_id, formatted_date, entry_tod, entry_emo_id, new_sym_entry_id, notes))
        connection.commit()

        # symptoms contains a list of strings e.g. [ "acne, 2", "insomnia , 2" ]
        # this needs to be changed to the format: [['acne', 2], ['insomnia', 2]] i.e. a list of lists

        symList = []
        for symptom in symptoms:
            x = symptom.split()
            x[1] = int(x[1])
            symList.append(x)

        # symList now contains the format : [ [ "acne", 2 ], [ "insomnia,", 2 ] ]

        # symptoms = [['acne', 2], ['insomnia', 2]]
        updatedlist = []

        for symptom in symList:
            sym_name = symptom[0]
            query = "SELECT sym_id FROM symptoms WHERE sym_name = '%s';"
            cursor.execute(query % sym_name)
            result = cursor.fetchone()
            updatedlist.append([result[0], symptom[1]])
        # at this point, updated list is a list of lists
        # with the format: [[symptom id, symptom severity],[symptom id, symptom severity], .....]

        for record in updatedlist:
            query = "INSERT INTO symptomentry (sym_entry_id, symptom_entry_sev, sym_id) VALUES ( %s, %s, %s);"
            cursor.execute(query, (new_sym_entry_id, record[1], record[0]))
            connection.commit()
        return "{'status': 'success'}"

    except Exception as e:
        error = "{'error': " + str(e) + "}"
        return error




