from django.shortcuts import render

# Create your views here.
from django.views.decorators.csrf import csrf_protect

from AI.rarea import get_dataframe, cal_RMSE, get_recommendations, add_user
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
## http://127.0.0.1:8000/trip/surveyResult/newSurveyResult?answer1=20&answer2=%EB%82%A8%EC%9E%90&answer3=1&answer4=%EC%84%9C%EC%9A%B8%ED%8A%B9%EB%B3%84%EC%8B%9C&answer6=1&answer7=4&answer8=1&answer9=1&answer10=1&answer11=1&answer12=1&answer13=%EB%AF%B8%ED%98%BC&answer14=%EB%8C%80%ED%95%99%EC%83%9D&answer16=10000&answer17=%EC%A4%91%EC%86%8C%EB%8F%84%EC%8B%9C


@method_decorator(csrf_exempt, name='dispatch')
@csrf_exempt
def newSurveyResult(req):
    data = req.POST
    print(data)
    new = {
    'userID' : [1000001],
    'age' : [int(str(data['answer1']).rstrip('대'))],
    'sex' : [data['answer2']],
    'living_area' : [data['answer4']],
    'living_area_size' : [data['answer16']],
    'occupation' : [data['answer14']],
    'family_size' : [int(str(data['answer7']).rstrip('명'))],
    'marry' : [data['answer13']],
    'income_per_year' : [int(str(data['answer15']).rstrip('만원 미만'))],

    # data['answer3']
    # data['answer5']
    # data['answer6']
    # data['answer8']
    # data['answer9']
    # data['answer11']
    # data['answer12']
    }
    # new_list = [*new.values()]
    new_list = [1000001, '남자', 20, '서울특별시', '중소도시', '대학생', 4, '미혼', 10000]
    userID = 1000001
    user, area, rating = get_dataframe()
    user = add_user(user, new)
    algo, trainset, testset = cal_RMSE(rating)
    recommendation = get_recommendations(userID, algo, user, rating, 50)
    print("recommendation:", recommendation)
    result = {
        "rarea" : recommendation,
        "ractivity" : "자연관광"
    }
    return render(req, 'surveyResult/surveryResult.html', result)
