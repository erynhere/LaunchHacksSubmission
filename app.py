from flask import Flask, redirect, url_for, request, render_template
import json
import random
import requests

VACCINE_SEQUENCE = [
  "HepB 1",
  "HepB 2",
  "DTap",
  "Hib",
  "IPV",
  "PCV",
  "Rotavirus"
]

# user id -> value
phone_mp = {}
age_mp = {}
pref_clinic_mp = {}
vaccines_taken_mp = {}
address_mp = {}

app = Flask(__name__)

def findNextVaccine(userId):
    vaccinesTaken = []
    if userId in vaccines_taken_mp:
        vaccinesTaken = vaccines_taken_mp[userId]

    for vaccine in VACCINE_SEQUENCE:
        if vaccine.lower() not in vaccinesTaken:
            return vaccine
    return None


def findNearByClinics(userId):
    clinics = []

    if userId in pref_clinic_mp:
        clinics.append(pref_clinic_mp[userId])

    address = None
    latitude = None
    longitude = None
    if userId in address_mp:
        address = address_mp[userId]


    API_KEY = "AIzaSyBDMlKyMKAJPxVN1IZziJuKBqIMKnMcMno"
    if address:
        url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=" + address + "&inputtype=textquery&fields=geometry&key=" + API_KEY
        response = requests.request("GET", url, headers={}, data={})
        res = json.loads(response.text)
        try:
            location = res["candidates"][0]["geometry"]["location"]
            latitude = location["lat"]
            longitude = location["lng"]
        except: 
            pass
    if not latitude or not longitude:
        return clinics
    
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + str(latitude) + "%2C" + str(longitude) + "&radius=10000&type=hospital&key=" + API_KEY
    response = requests.request("GET", url, headers={}, data={})
    res = json.loads(response.text)
    for result in res["results"]:
        if result["name"] not in clinics:
            clinics.append(result["name"])
    return clinics[:3]


@app.route('/success/<userId>', methods=['GET', 'POST'])
def success(userId):

    nextVaccine = findNextVaccine(userId)
    clinics = findNearByClinics(userId)

    return 'Next vaccine: %s<br> Nearest clinics: %s<br><br><a href="/">Search again</a>' % (nextVaccine, clinics)

@app.route('/user/<userId>')
def user(userId):
    return {
        "user_id": userId,
        "phone_no": phone_mp.get(userId, ""),
        "childs_age": age_mp.get(userId, ""),
        "pref_clinic": pref_clinic_mp.get(userId, "")
    }

@app.route('/clinicsNearby/<userId>')
def clinicsNearby(userId):
    return {"clinicsNearby": findNearByClinics(userId)}

@app.route('/vaccinesTaken/<userId>')
def vaccinesTaken(userId):
    out = []

    for i, name in enumerate(vaccines_taken_mp.get(userId, [])):
        month = random.randint(1, 12)
        day = random.randint(1, 28)
        year = 2020 - age_mp.get(userId, 10) + i
        out.append({"name": name, "dategiven": "%02d/%02d/%d" % (month, day, year)})
    return {
        "vaccines" : out
    }

@app.route('/vaccinesNext/<userId>')
def vaccinesNext(userId):
    nextVaccine = findNextVaccine(userId)
    nextVaccines = []
    if nextVaccine:
        nextVaccines.append({"name": nextVaccine, "year": "2024"})

    return {
        "vaccines" : nextVaccines
    }

@app.route('/', methods=['POST', 'GET'])
def index():
    global phone_mp, age_mp, pref_clinic_mp, address_mp, vaccines_taken_mp
    if request.method == 'POST':
        userId = request.form['userId']

        phone = request.form['phone'].strip()
        if phone:
            phone_mp[userId] = phone

        try:
            age = int(request.form['age'].strip())
            if age:
                age_mp[userId] = age
        except:
            pass

        vaccinesTaken = request.form['vaccinesTaken']
        vaccinesTakenArr = vaccinesTaken.split(",")
        for i in range(len(vaccinesTakenArr)):
            vaccinesTakenArr[i] = vaccinesTakenArr[i].strip().lower()
        if vaccinesTakenArr:
            vaccines_taken_mp[userId] = vaccinesTakenArr

        
        address = request.form['address']
        if address:
            address_mp[userId] = address

        prefClinic = request.form['prefClinic']
        if prefClinic:
            pref_clinic_mp[userId] = prefClinic

        return redirect(url_for('success', userId=userId))
    else:
        return render_template('index.html')
 
 

if __name__ == "__main__":
    app.run(debug=True)
