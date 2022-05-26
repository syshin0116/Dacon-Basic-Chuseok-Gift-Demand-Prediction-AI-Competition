from django.shortcuts import render

# Create your views here.
from surveyResult.models import SurveyResult


def all(req):
    surveyResultList = SurveyResult.objects.all()
    context = {'surveyResultList': surveyResultList}
    return render(req, 'surveyResult/all.html', context)
