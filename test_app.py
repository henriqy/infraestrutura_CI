import pytest
from app import add

def test_add():
    assert add(1, 2) == 3
    assert add(-1, 1) == 0
    assert add(-1, -1) == -2
    assert add(-5, -3) == -8

    
    assert add(3, 5) == 8
    assert add(2, 10) == 12 
    assert add(2, 3) == 5
    assert add(10, 7) == 17

    
