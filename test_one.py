""" Test the "one" module. """

from one import zero, one, two


def test_zero():
    """ Fails if zero is wrong."""
    assert zero() == 0


def test_one():
    """ Return 1 """
    assert one() == 1


def test_two():
    """ Return 2 """
    assert two() == 2
