from django.db import models


class Book(models.Model):
    objects = None
    title = models.CharField(max_length=100)
    author = models.CharField(max_length=100)
    published_date = models.DateField()
    isbn_number = models.CharField(max_length=13)

    def __str__(self):
        return self.title