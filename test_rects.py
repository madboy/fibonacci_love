from nose.tools import *
import rects

def test_two_unequal():
    weights = [0.75, 0.25]
    width = 100
    height = 100
    response = rects.get_rects(weights, height, width)
    (fh, fw, fx, fy) = response[0]
    (sh, sw, sx, sy) = response[1]
    assert_equal(fh*fw, 7500)
    assert_equal((fx,fy), (0,o))
    #assert_equal(response, [(75.0, 75.0, 0, 0), (25.0, 25.0, 75.0, 0)])

#def test_four_equal():
#    weights = [0.25, 0.25, 0.25, 0.25]
#    width = 100
#    height = 100
#    response = rects.get_rects(weights, height, width)
#    assert_equal(response, [(25.0, 25.0), (25.0, 25.0), (25.0, 25.0), (25.0, 25.0)])
#
#def test_four_eqaul_uneven_area():
#    weights = [0.25, 0.25, 0.25, 0.25]
#    width = 200
#    height = 100
#    response = rects.get_rects(weights, height, width)
#    assert_equal(response, [(25.0, 50.0), (25.0, 50.0), (25.0, 50.0), (25.0, 50.0)])
