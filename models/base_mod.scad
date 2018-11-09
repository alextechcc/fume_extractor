pot_hole_r = 6.9 / 2;
pot_hole_h = 5.4;

off = 23;

pot_w = 20;
pot_h = 30;
pot_d = 9.1;

height = 117 - 3;

switch_h_r = 6.24 / 2;
switch_h_d = 6.2;
switch_h_w = 5.40;

switch_b_w = 11.55;
switch_b_h = 13.20;
switch_b_d = 9;

intersection() {
    difference() {
        import("fume_extractor_foot.STL", convexity=5);

        translate([82.5,48,height/2])
        rotate([-43,90,0])
        union() {
            // Pot
            translate([-off,0,0])
            union() {
                cylinder(r=pot_hole_r, h=pot_hole_h, $fn=25);
                translate([0,6,-4])
                cube([pot_w,pot_h,pot_d],center=true);
            }

            // Switch
            translate([off,0,2.2])
            union() {
                intersection() {
                    cube([switch_h_w, 20, switch_h_d], center=true);
                    cylinder(r=switch_h_r, h=switch_h_d, center=true, $fn=30);
                }
                translate([0,0,-6.5])
                cube([switch_b_w, switch_b_h, switch_b_d], center=true);
            }
        }
    }

    /*
    // isolate pot
    rotate([0,0,30])
    translate([74,-13,68])
    cube([50,40,25]);

    // Isolate switch
    rotate([0,0,30])
    translate([69,-10,27])
    cube([50,20,14]);
    */
}
