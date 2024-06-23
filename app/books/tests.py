from datetime import datetime

from django.urls import reverse
from rest_framework.test import APITestCase
from rest_framework import status
from books.models import Book


class BooksTest(APITestCase):
    def test_create_book(self):
        payload = {
            "title": "test title",
            "author": "nimal",
            "published_date": "2012-07-20",
            "isbn_number": "4343434"
        }

        response = self.client.post(
            reverse('book:book-list'),
            payload, format='json'
        )
        print(response.data['published_date'])
        print(response.data['id'])
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        book = Book.objects.get(id=response.data['id'])

        # Ensure the book attributes match the payload
        for key, value in payload.items():
            if key == 'published_date':
                self.assertEqual(
                    getattr(book, key),
                    datetime.strptime(value, '%Y-%m-%d').date()
                )
            else:
                self.assertEqual(getattr(book, key), value)
