""" Test the "one" module. """

import pytest
from one import *

def test_zero():
    """ Fails if zero is wrong."""
    assert zero()== 0


def test_one():
    """ Return 1 """
    return 1


def test_two():
    """ Return 2 """
    return 2
