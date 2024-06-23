from rest_framework import routers
from books.views import BookViewSet
from django.urls import path, include

router = routers.DefaultRouter()
router.register(r'books', BookViewSet)

app_name = 'book'
urlpatterns = [
    path('', include(router.urls)),
]
