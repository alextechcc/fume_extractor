/*
 * r = radius
 * w = width (left/right)
 * d = depth (forwards/back)
 * h = height (up/down)
 * spc = spacing
 * off = offset
 */

module corners(w,d) {
    translate([-w/2,-d/2,0]) children(0);
    translate([-w/2,d/2,0]) children(0);
    translate([w/2,-d/2,0]) children(0);
    translate([w/2,d/2,0]) children(0);
}

module sides(s, flip=false, all=false) {
    if (flip || all) {
        rz(0) ty(s/2) children(0);
        rz(180) ty(s/2) children(0);
    }
    if (!flip || all){
        rz(90) ty(s/2) children(0);
        rz(270) ty(s/2) children(0);
    }
}

module mirror_duplicate(axis) {
    mirror([axis.x,0,0])
    mirror([0,axis.y,0])
    mirror([0,0,axis.z])
        children(0);
    children(0);
}

module tx(x) {
    for (i = [0:$children-1])
        translate([x,0,0]) children(i);
}
module ty(y) {
    for (i = [0:$children-1])
        translate([0,y,0]) children(i);
}
module tz(z) {
    for (i = [0:$children-1])
        translate([0,0,z]) children(i);
}
module rx(x) {
    for (i = [0:$children-1])
        rotate([x,0,0]) children(i);
}
module ry(y) {
    for (i = [0:$children-1])
        rotate([0,y,0]) children(i);
}
module rz(z) {
    for (i = [0:$children-1])
        rotate([0,0,z]) children(i);
}


module box(dims) {
    tz(dims.z/2) cube(dims, center=true);
}

module rounded_rectangle(w, d, h, r) {
    linear_extrude(height=h)
        hull()
            corners(w=w-(r*2),d=d-(r*2))
                circle(r=r);
}

module tube(ir, or, h) {
    difference() {
        cylinder(r=or,h=h);
        tz(-0.01)
        cylinder(r=ir,h=h+0.02);
    }
}
