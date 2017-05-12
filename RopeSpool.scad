$fn=50;


full_assembly();

//rotate([180,0,0])print_half1();
//rotate([180,0,0])print_half2();
//handler();
//rotate([180,0,0])kork();
//stopper();


module print_half1(){
    Spool_half();
    difference(){
        translate([0,0,-35])cylinder(d=35,h=3);
        translate([0,0,-34])cube([10,40,3], center=true);
        translate([0,0,-35.1])cylinder(d=30,h=4);
    }
}

module print_half2(){
    difference(){
        Spool_half();
        difference(){
            translate([0,0,-32.6])cylinder(d=35.2,h=3);
            translate([0,0,-31])cube([9.8,40,3], center=true);
        }
        translate([-14,0,-12])rotate([90,0,0])cylinder(d=5, h=40,center=true); 
        
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
        translate([0,0,-72])kork();
        translate([0,0,-100])cube([50,50,150]);
    }

    translate([0,0,10])stopper();
    
    bolt(8,150);
    translate([0,0,-150/2+7])lcoknut(8);

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
            cylinder(d=80,h=2, center=true, $fn=$fn*2);
            translate([0,0,-5])cylinder(d1=40, d2=80,h=8, center=true,$fn=$fn*2);
            translate([0,0,-20])cylinder(d=40,h=25, center=true);
        }
        cylinder(d=18,h=100, center=true);
        translate([0,0,-40])cylinder(d=30,h=27);
        //translate([0,0,-60])cylinder(d2=30, d1=22,h=30);
        translate([0,0,7-10])cylinder(d=22.2,h=12, center=true); // 10mm deep for bearing
        translate([0,0,1.6-12])cylinder(d2=22.2, d1=17,h=3, center=true); // 10mm deep for bearing
        magnetsockets();
        translate([17,30,0])cylinder(d=5, h=10, center=true);
        //translate([0,0,-40])cylinder(d=30,h=20);
    }
}

module magnetsockets(){
    for(i=[30:60:330]){rotate([0,0,i])translate([23,0,0])cylinder(d=10.2,h=2.1, center=true,$fn=$fn/2);}
}

module handler(){
    difference(){
        union(){
            cylinder(d=14, h=5);
            translate([0,0,4])cylinder(d1=16, d2=30, h=90);
            translate([0,0,2])cylinder(d1=14, d2=16, h=2);
            translate([0,0,95])sphere(d=30);
            translate([10,0,10])stopper_holder();
        }
        translate([0,0,-1])cylinder(d=8.2, h=90);
        translate([0,0,75])cylinder(d=8*2+0.3,h=40,$fn=6);
        translate([0,0,107.5])cube([50,50,2], center=true);
            
        translate([9,0,11])rotate([90,0,0])cylinder(d=3.1,h=16, center=true); // hole for stopper
        translate([11.5,0,10])rotate([90,0,0])cylinder(d=14,h=7, center=true); // hole for stopper
    }
}

module kork(){
    difference(){
        cylinder(d=22,h=8);
        cylinder(d=18,h=9);
    }
    difference(){
        sphere(d=22);
        translate([0,0,11+4])cube([30,30,30], center=true);
        sphere(d=18);
    }
}

module stopper_holder(){
    hull(){
        translate([-1,0,1])rotate([90,0,0])cylinder(d=9,h=15, center=true);
        translate([-9,0,-1])cube([7,13,18], center=true);
    }
}

module stopper() {
    difference(){
        hull(){
            translate([9,0,1])rotate([90,0,0])cylinder(d=8,h=6.7, center=true);
            translate([18,0,-7])cube([15,6.7,2], center=true);
        }
        translate([9,0,1])rotate([90,0,0])cylinder(d=3.3,h=7, center=true);
    }
    
    difference(){
        hull(){
            rotate([0,0,30])translate([23,0,-9])cylinder(d=14, h=4);
            rotate([0,0,-30])translate([23,0,-9])cylinder(d=14, h=4);
            translate([17,0,-9])cylinder(d=14, h=3);
        }
        rotate([0,0,30])translate([23,0,-9])cylinder(d=10.2, h=2);
        rotate([0,0,-30])translate([23,0,-9])cylinder(d=10.2, h=2);
    }
    
    rotate([0,15,0])stopper_fingerpad();    
}

module stopper_fingerpad(){
    translate([10,0,16])rotate([0,90,0])cylinder(d=16,h=3, center=true);
    hull(){
        translate([10,0,8])cube([3,6.7,5],center=true);
        translate([15,0,4])cube([3,6.7,1],center=true);
    }
}