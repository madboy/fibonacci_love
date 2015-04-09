#!/usr/bin/env python

def odd(n):
    if (n % 2) == 0:
        return True
    else:
        return False


def get_rects(weights, width, height):
    """Split an area based on weights

    """
    rects = []
    x = 0
    y = 0
    for i, weight in enumerate(weights):
        w = width * weight
        h = height * weight
        rects.append((w, h, x, y))
        if odd(i):
            x += w
        else:
            y += h
    return rects

if __name__ == '__main__':
    pass
