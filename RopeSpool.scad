$fn=100;


full_assembly();

//rotate([180,0,0])print_half1();
//rotate([180,0,0])print_half2();
//handler();
//rotate([180,0,0])kork();
//stopper();


module print_half1(){
    union(){
        Spool_half();
        difference(){
            translate([0,0,-35])cylinder(d=26,h=3);
            translate([0,0,-34])cube([10,40,3], center=true);
            translate([0,0,-35.1])cylinder(d=23,h=4);
        }
    }
}

module print_half2(){
    difference(){
        Spool_half();
        difference(){
            translate([0,0,-32.6])cylinder(d=26.25,h=3);
            translate([0,0,-31])cube([9.8,40,3], center=true);
        }
        translate([-11,0,-13])rotate([90,0,0])cylinder(d=4, h=40,center=true); 
    }
}


module full_assembly(){
    difference(){
        Spool_half();
        translate([0,0,-50])cube([100,100,100]);
    }

    difference(){
        translate([0,0,-65])mirror([0,0,1])Spool_half();
        translate([0,0,-90])cube([100,100,100]);
    }

    difference(){
        handler();
        translate([0,0,0])cube([50,50,150]);
    }


    difference(){
        translate([0,0,-66])kork();
        translate([0,0,-100])cube([50,50,150]);
    }

    translate([0,0,11.5])stopper();
    
    translate([0,0,16])rotate([180,0,0])bolt(8,160);
    translate([0,0,150/2+15])lcoknut(8);

    translate([0,0,-5])bearing8x22x7();
    mirror([0,0,1])translate([0,0,60])bearing8x22x7();
    
}

module bolt(diam,L){
    color("LIGHTGREY"){
        cylinder(d=diam,h=L,center=true);
        translate([0,0,L/2+diam*0.7/2])cylinder(d=diam*2,h=diam*0.7,$fn=6,center=true);
    }
}

module lcoknut(diam){
    color("LIGHTGREY")difference(){
        cylinder(d=diam*2,h=8,$fn=6,center=true);
        cylinder(d=diam,h=11,center=true);
    }
}

module bearing8x22x7(){
    color("GREY")difference(){
        union(){
            difference(){cylinder(d=22,h=7, center=true);cylinder(d=18,h=8, center=true);}
            cylinder(d=12,h=7, center=true);
            cylinder(d=20,h=6, center=true);
        }
        cylinder(d=8,h=9, center=true);
    }
}

module Spool_half(){
    difference(){
        union(){
            cylinder(d=65,h=2, center=true, $fn=$fn*2);
            translate([0,0,-5])cylinder(d1=30, d2=65,h=8, center=true,$fn=$fn*2);
            translate([0,0,-20])cylinder(d=30,h=25, center=true);
        }
        cylinder(d=18,h=100, center=true);
        translate([0,0,-40])cylinder(d=23,h=27);
        //translate([0,0,-60])cylinder(d2=30, d1=22,h=30);
        translate([0,0,7-10])cylinder(d=22.3,h=12, center=true); // 10mm deep for bearing
        translate([0,0,1.6-12])cylinder(d2=22.2, d1=17,h=3, center=true); // 10mm deep for bearing
        magnetsockets();
        translate([13,24,0])cylinder(d=4, h=10, center=true);
        //translate([0,0,-40])cylinder(d=30,h=20);
        translate([36,0,0])cube([10,40,5], center=true);
        translate([33,0,1.5])rotate([0,45,0])cube([5,5,5], center=true);
    }
}

module magnetsockets(){
    for(i=[30:60:330]){rotate([0,0,i])translate([23,0,0])cylinder(d=10.3,h=4, center=true,$fn=$fn/2);}
}

module handler(){
    difference(){
        union(){
            cylinder(d=14, h=5);
            translate([0,0,4])cylinder(d1=16, d2=30, h=110);
            translate([0,0,2])cylinder(d1=14, d2=16, h=2);
            translate([0,0,115])sphere(d=30);
            translate([10,0,10])stopper_holder();
        }
        translate([0,0,-1])cylinder(d=8.3, h=90);
        translate([0,0,85])cylinder(d=8*2-0.4,h=50,$fn=6);
        //translate([0,0,85])cylinder(d=13+0.5,h=30,$fn=$fn/2);
        translate([0,0,107.5+20])cube([50,50,2], center=true);
            
        translate([9,0,12.5])rotate([90,0,0])cylinder(d=3.15,h=16, center=true); // hole for stopper
        translate([11.5,0,11.5])rotate([90,0,0])cylinder(d=14,h=7.1, center=true); // hole for stopper
    }
}

module kork(){
    difference(){
        union(){
            difference(){
                cylinder(d=22,h=2);
                cylinder(d=18,h=7);
            }
            difference(){
                sphere(d=22);
                translate([0,0,11+4])cube([30,30,30], center=true);
                sphere(d=18);
            }
        }
        cube([3, 25,5],center=true);
    }
}

module stopper_holder(){
    hull(){
        translate([-1,0,2.5])rotate([90,0,0])cylinder(d=9,h=15, center=true);
        translate([-9,0,-1])cube([7,13,18], center=true);
    }
}

module stopper() {
    difference(){
        hull(){
            translate([9,0,1])rotate([90,0,0])cylinder(d=8,h=6.5, center=true);
            translate([18,0,-7])cube([15,6.5,2], center=true);
        }
        translate([9,0,1])rotate([90,0,0])cylinder(d=3.4,h=7, center=true);
    }
    
    difference(){
        hull(){
            rotate([0,0,30])translate([23,0,-9])cylinder(d=14, h=4);
            rotate([0,0,-30])translate([23,0,-9])cylinder(d=14, h=4);
            translate([17,0,-9])cylinder(d=14, h=3);
        }
        rotate([0,0,30])translate([23,0,-9])cylinder(d=10.3, h=2.6);
        rotate([0,0,-30])translate([23,0,-9])cylinder(d=10.3, h=2.6);
    }
    
    rotate([0,20,0])stopper_fingerpad();    
}

module stopper_fingerpad(){
    translate([10,0,17])rotate([0,90,0])cylinder(d=17,h=3, center=true);
    hull(){
        translate([10,0,9])cube([3,6.5,5],center=true);
        translate([16,0,5])cube([3,6.5,1],center=true);
    }
}