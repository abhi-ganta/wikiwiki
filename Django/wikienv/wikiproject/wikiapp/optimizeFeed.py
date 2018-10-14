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

def jobPredict(X_train, y_train, X_predict):
    model = LogisticRegression()

    # model = RandomForestClassifier(n_estimators = 400, max_depth = 70, max_features = 'auto')

    model = GradientBoostingClassifier(n_estimators = 1000, max_depth = 3, learning_rate = 0.1)

    X_tr, X_te, y_tr, y_te = train_test_split(X_train, y_train, test_size=0.2, random_state=42)

    model.fit(X_tr, y_tr)

    prediction_prob = model.predict_proba(X_predict)

    X_te = X_te.dropna()
    accuracy = model.score(X_te, y_te)

    return prediction_prob[:,1], accuracy

def optimizeFeedApi(requestJson):

    oldData = requestJson['old']

    X_cols = ['aLen', 'c0', 'c1', 'c2', 'c3', 'c4', 'qLen']

    old = pd.DataFrame(oldData)

    X = old[X_cols]
    y = old['voted']

    # newthing = newthing.transpose()

    print (X)
    print (y)

    # trainData = requestJson['old-data']
    # testData = requestJson['to-predict']
    #
    # trainData = read_json(trainData)
    # testData = read_json(testData)
    #
    # X_cols = ['']
    #
    # X_train = trainData[X_cols]
    # y_train = trainData['result']
    #
    # X_predict = testData[X_cols]
    # jobMatchProb, accuracy = jobPredict(X_train, y_train, X_predict)



    return requestJson
