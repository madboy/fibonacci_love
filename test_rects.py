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
    assert_equal((fx,fy), (0,0))

    assert_equal(sh*sw, 2500)
    assert_equal((sx,sy), (75, 0))


def test_four_equal():
    weights = [0.25, 0.25, 0.25, 0.25]
    width = 100
    height = 100
    response = rects.get_rects(weights, height, width)

    (fh, fw, fx, fy) = response[0]
    (sh, sw, sx, sy) = response[1]
    (th, tw, tx, ty) = response[2]
    (foh, fow, fox, foy) = response[3]

    assert_equal(fh*fw, 2500)
    assert_equal((fx,fy), (0,0))

    assert_equal(sh*sw, 2500)
    assert_equal((sx,sy), (25, 0))

    assert_equal(th*tw, 2500)
    assert_equal((tx,int(ty)), (25, 33))

    assert_equal(int(foh*fow), 2500)
    assert_equal((int(fox),int(foy)), (62, 33))


#def test_four_eqaul_uneven_area():
#    weights = [0.25, 0.25, 0.25, 0.25]
#    width = 200
#    height = 100
#    response = rects.get_rects(weights, height, width)
#    assert_equal(response, [(25.0, 50.0), (25.0, 50.0), (25.0, 50.0), (25.0, 50.0)])
