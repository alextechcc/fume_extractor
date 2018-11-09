use <util.scad>

screw_p = [14.60, 11.14];
header_1_w = 6.02;
header_2_w = 3.68;
header_1_h = 11.3;
header_2_h = 13.84;
header_1_p = [-17.31, 2.8 - header_1_h/2];
header_2_p = [-11.3, 2.8 - header_2_h/2];

regulator_p = [9.55, 8.43];
regulator_w = 10.5;
regulator_h = 2;


screw_r = 3/2;
screw_h = 5;

thickness = 2;
space = 2;
tolerance = 0.3;

insert_d = 6;
insert_r = 4.8 / 2;

board_w = 35.56;
board_d = 28.57;
board_t = 1.58;

jack_p = [-board_w/2 - 4, 9.14, 12];
jack_r = 10.5 / 2;

case_w = board_w + thickness + space;
case_d = board_d + thickness + space;
case_h = 19;


f = 0.01;

explode = 8;

module board() {
    color([0.5,1,0.5])
    tz(1.6 + 2.4 + board_t)
        import("../exports/pcb_mesh.stl", convexity = 5);
}

module mounts() {
    mirror_duplicate([1,1,0])
    translate(screw_p)
        children(0);
}

module case() {
    difference() {
        union() {
            difference() {
                box([case_w, case_d, case_h]);
                tz(thickness)
                    box([case_w-thickness, case_d - thickness, case_h - thickness + f]);
            }
            tz(thickness) mounts() cylinder(r=screw_r*2, h=2, $fn=50);
        }
        tz(-f) mounts() cylinder(r=screw_r, h=screw_h, $fn=50);
        translate(jack_p) ry(90) cylinder(r=jack_r, h=5, $fn=40);
    }
    rx(explode*4) tz(case_h + explode) color([0.5,0.2,0.8]) children(0);
}

module lid() {
    difference() {
        union() {
            box([case_w,case_d,thickness]);
            tz(-thickness)
                box([case_w-thickness-tolerance,case_d-thickness-tolerance,thickness]);
        }
        tz(-thickness-f)
            box([case_w-thickness*2,case_d-thickness*2,thickness+f]);

        tx(header_1_w/2)
        translate(header_1_p)
            box([header_1_w,header_1_h,30]);

        tx(header_2_w/2)
        translate(header_2_p)
            box([header_2_w,header_2_h,30]);

        translate(regulator_p)
            box([regulator_w,regulator_h,30]);
    }
}

board();

case() lid();
//case();
//lid();
