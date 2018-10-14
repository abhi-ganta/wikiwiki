import json
import random
import string
import pandas as pd
from pymongo import MongoClient
from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.ensemble import AdaBoostClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
from sklearn import preprocessing

def feedOptimize(X_train, y_train, X_predict):
    model = LogisticRegression()

    # model = RandomForestClassifier(n_estimators = 400, max_depth = 70, max_features = 'auto')

    # model = GradientBoostingClassifier(n_estimators = 1000, max_depth = 3, learning_rate = 0.1)

    X_tr, X_te, y_tr, y_te = train_test_split(X_train, y_train, test_size=0.2, random_state=42)

    model.fit(X_tr, y_tr)

    prediction_prob = model.predict_proba(X_predict)

    X_te = X_te.dropna()
    accuracy = model.score(X_te, y_te)

    return prediction_prob[:,1], accuracy

def optimizeFeedApi(requestJson):

    oldData = requestJson['old']
    newData = requestJson['new']

    X_cols = ['aLen', 'c0', 'c1', 'c2', 'c3', 'c4', 'c5', 'c6', 'qLen']

    trainData = pd.DataFrame(oldData)
    testData = pd.DataFrame(newData)

    X_train = trainData[X_cols]
    y_train = trainData['voted']
    X_predict = testData[X_cols]
    predict_ids = testData['poll_id']

    predict_ids = pd.DataFrame(predict_ids)

    feedProb, accuracy = feedOptimize(X_train, y_train, X_predict)

    feedProb = pd.DataFrame(feedProb)

    prediction_bind = predict_ids.join(feedProb)

    prediction_bind.columns = ['predict_id', 'prob']

    print(prediction_bind)

    returnResponse = {
        'accuracy': accuracy,
        'predictions': []
    }

    predictionReturn = returnResponse['predictions']

    for index, x in prediction_bind.iterrows():
        oneProb = {
            'poll_id': x['predict_id'],
            'probability': x['prob']
        }
        predictionReturn.append(oneProb)

    return returnResponse
