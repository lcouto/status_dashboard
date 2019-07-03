from flask import Flask, jsonify, abort, request, render_template
from redis import Redis
import datetime
import time
import calendar
import os


app = Flask(__name__)
redis = Redis(host='redis', port=6379)


devices = {}

def convertBytes(data):
    if isinstance(data, bytes):  return data.decode('utf-8')
    if isinstance(data, dict):   return dict(map(convertBytes, data.items()))
    if isinstance(data, tuple):  return map(convertBytes, data)
    return data

@app.route('/status')
def status():
    converted = convertBytes(redis.hgetall('deviceDict'))
    return render_template('index.html', devices = converted, time = calendar.timegm(time.gmtime()))


@app.route('/status/update', methods=['POST'])
def create_entry():
    if not request.json or not 'mac_id' and 'time' in request.json:
        abort(400)
    device = {
        request.json['mac_id']: request.json['time']
    }
    devices.update(device)
    redis.hmset("deviceDict", devices)
    return jsonify({'device': device}), 201


# @app.route('/status/update', methods=['DELETE'])
# def delete_device(task_id):
#     if not request.json or not 'mac_id' and 'time' in request.json:
#         abort(400)
#     device = {
#         request.json['mac_id']: request.json['time']
#     }
#     devices.update(device)
#     return jsonify({'result': True})


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0',port=8080)