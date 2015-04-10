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
    lh = height
    lw = width
    for i, weight in enumerate(weights):
        if odd(i):
            h = lh
            w = (width * height * weight) / h
            rects.append((w, h, x, y))
            x += w
            lw = lw - w
        else:
            w = lw
            h = (width * height * weight) / w
            rects.append((w, h, x, y))
            y += h
            lh = lh - h
    return rects

if __name__ == '__main__':
    pass
