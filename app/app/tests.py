from django.test import SimpleTestCase

from . import calc


class CalcTests(SimpleTestCase):

    def test_add_numbers(self):
        res = calc.add(7, 4)
        self.assertEqual(res, 11)
        self.assertNotEqual(res, 0)

    def test_subtraction_numbers(self):
        res = calc.subtraction(6, 2)

        self.assertEqual(res, 4)
