$fn=180;


buttonOuter = 46;
//buttonOuter = 38;
// How big the cutout for the buttons is.
// Large buttons = 29mm
// Small buttons = 25mm
buttonInner = 29;

labelHeight = 41;
labelLength = 90;

photonPcbHeight = 37; //40;
photonPcbLength = 70; //100;

// Feather has onboard battery charger.
//featherPcbHeight = 52;
//featherPcbLength = 100;

//photonRelayPcbHeight = 32;
//photonRelayPcbLength = 100;

rfidPcbHeight = 51;
rfidPcbLength = 90;

caseHeight = 36; // Button min is 33mm
spaceBetweenButtons = 130;

wallWidth = 2;

module showPcb() {
    // Move to the center then adjust back from there...
    translate([spaceBetweenButtons/2,0,0]) {
            
        translate([-(photonPcbLength/2), -(photonPcbHeight)/2, 0]) {
            // PCB
            cube([photonPcbLength, photonPcbHeight, 1.6]);
            
            // Photon
            translate([(photonPcbLength-22)/2,0,1.6]) {
                cube([22, photonPcbHeight+2, 4]); // 16mm for socketed
            }
          
            
            // Battery
            translate([(photonPcbLength-44)/2 ,19,-18]) {
                cube([44, 18, 18]);
            }
        }
        

        
        // mounts.
        translate([-31, -14.5, 0]) {
            cylinder(d=3.2, h=10);
        }
        
        translate([31, 14.5, 0]) {
            cylinder(d=3.2, h=10);
        }
        
        translate([31, -14.5, 0]) {
            cylinder(d=3.2, h=10);
        }
    }
}

module showModels() {
    
    // Label
    translate([(spaceBetweenButtons  - labelLength)/2,(-labelHeight)/2,caseHeight]) {
       #cube([labelLength, labelHeight, 2]);
    }
    
    // Button tops
    translate([0,0,caseHeight]) {
        cylinder(d=34, h=9);

        // 122mm gives a nice gap for a 99012 label between buttons
        translate([spaceBetweenButtons, 0, 0]) {
            cylinder(d=34, h=9);
        }
    }
    
    // Button body
    translate([0,0,caseHeight-33]) {
        cylinder(d=28, h=33);

        // 122mm gives a nice gap for a 99012 label between buttons
        translate([spaceBetweenButtons , 0, 0]) {
            cylinder(d=25, h=33);
        }
    }
    
    // Button nuts
    translate([0,0,caseHeight-11]) {
        cylinder(d=36, h=11);

        // 122mm gives a nice gap for a 99012 label between buttons
        translate([spaceBetweenButtons , 0, 0]) {
            cylinder(d=36, h=11);
        }
    }
    
    // Photon PCB
    // TODO: Find a decent X position!    
}

module pcbMount(x,y, h, hollowDepth) {
    translate([x,y,0]) {
        difference() {
            union() {
                cylinder(d=8, h=h);
            }
            union() {
                translate([0,0,-0.1]) {
                    #cylinder(d=4.2, h=hollowDepth);
                }
            }
        }
    }
}

module pcbPin(x,y, h, pinHeight) {
    translate([x,y,0]) {
        cylinder(d=8, h=h);
        
    }
    
    translate([x,y,h-1]) {
        cylinder(d1=2.8, d2=2.0, h=4);
    }
}


module pcbMounts() {
    
    // 1mm from base so printer doesn't try to 
    // put them on first layer.
    translate([spaceBetweenButtons/2,0,0]) {
        pcbMount(-31, -14.5, 12, 0); // not PCB hole, but use for support when puttin battery in.
        pcbMount(-31, 14.5, 12, 20); 
        pcbMount(31, -14.5, 12, 20);
        pcbPin(31, 14.5, 12, 20);
    }
}

// Also works for the Photon prototype PCB
// 5mm set in to allow the proto PCB to be used
// to behin with - and to allow the lid to cone 
// into the box for more strength
module caseLidMounts() {
    // 1mm from base so printer doesn't try to 
    // put them on first layer.
    
    
    // Offset from button center.
    // gap between buttons...
    // spaceBetweenButtons
    // (spaceBetweenButtons - 100)/2
    echo((spaceBetweenButtons - 100)/2);
    
    
    // +/- 4mm from edges for Photon Wide PCB
    translate([(spaceBetweenButtons - 100)/2, 0, 4.2]) {
        pcbMount(4, -32/2, caseHeight-4.5, 20);
        pcbMount(4, 32/2, caseHeight-4.5, 20);
        pcbMount(100-4, -32/2, caseHeight-4.5, 20);
        pcbMount(100-4, 32/2, caseHeight-4.5, 20);
    }
}


module lidScrewHole(x,y,depth) {
    translate([x,y,-0.1]) {
        cylinder(d=3.5, h=depth);
        cylinder(d1=8, d2=3.5, h=3);
    }
}

module caseLidHoles(lidThicknessInner) {
    // Screw holes for lid mounts...
    translate([(spaceBetweenButtons - 100)/2, 0, -1]) {
        lidScrewHole(4, -32/2, lidThicknessInner+5);
        lidScrewHole(4, 32/2, lidThicknessInner+5);
        lidScrewHole(100-4, -32/2, lidThicknessInner+5);
        lidScrewHole(100-4, 32/2, lidThicknessInner+5);
    }
}

module case() {
    difference() {
        union() {
            cylinder(d=buttonOuter, h=caseHeight);

            translate([0, -(buttonOuter/2), 0]) {
                cube([spaceBetweenButtons , buttonOuter, caseHeight]);
            }

            // 122mm gives a nice gap for a 99012 label between buttons
            translate([spaceBetweenButtons , 0, 0]) {
                cylinder(d=buttonOuter, h=caseHeight);
            }
        }
        union() {            
            translate([0,0,-1.5]) {
                cylinder(d=buttonOuter-(2*wallWidth), h=caseHeight);

                translate([0, -(buttonOuter/2) + wallWidth, 0]) {
                    cube([spaceBetweenButtons , buttonOuter-(2*wallWidth), caseHeight]);
                }

                // 122mm gives a nice gap for a 99012 label between buttons
                translate([spaceBetweenButtons , 0, 0]) {
                    cylinder(d=buttonOuter-(2*wallWidth), h=caseHeight);
                }
            }
            
            // The holes for the buttons in the panel.
            translate([0,0,0]) {
                cylinder(d=buttonInner, h=caseHeight+2);

                translate([spaceBetweenButtons , 0, 0]) {
                    cylinder(d=buttonInner, h=caseHeight+2);
                }
            }
        }
    }
}


module lid() {
lidThickness = 2;
lidThicknessInner = lidThickness + 3;
wallWidthTollerance = (wallWidth + 0.15) *2;
    
    difference() {
        union() {
            
            pcbMounts();
            
            // Base of the lid.
            translate([0,0,-1]) {
                cylinder(d=buttonOuter, h=lidThickness);

                translate([0, -(buttonOuter/2), 0]) {
                    cube([spaceBetweenButtons , buttonOuter, lidThickness]);
                }

                // 122mm gives a nice gap for a 99012 label between buttons
                translate([spaceBetweenButtons , 0, 0]) {
                    cylinder(d=buttonOuter, h=lidThickness);
                }
                
                //caseLidMounts();
            }
            
            // lid inner.
            translate([0,0, 0]) {
                cylinder(d=buttonOuter - wallWidthTollerance, h=lidThicknessInner);

                translate([0, -(buttonOuter-wallWidthTollerance)/2, 0]) {
                    cube([spaceBetweenButtons, buttonOuter-wallWidthTollerance, lidThicknessInner]);
                }

                // 122mm gives a nice gap for a 99012 label between buttons
                translate([spaceBetweenButtons , 0, 0]) {
                    cylinder(d=buttonOuter-wallWidthTollerance, h=lidThicknessInner);
                }
            }
            
        }
        union() {
            caseLidHoles(lidThicknessInner);
                
            // Cutout a little for the button wires
            cylinder(d=25+10, h=8);
            
            translate([0, -(15)/2, 0]) {
                cube([spaceBetweenButtons, 15, 8]);
            }

            translate([spaceBetweenButtons , 0, 0]) {
                cylinder(d=25+10, h=8);
            }
        }
    }
}

%showModels();

showCase = false;
showLid = true;

if (showCase) {
    case();
    
    caseLidMounts();
}

if (showLid) {
    translate([0,0,-1]) {
        
        translate([00,0,12+1.6]) {
            rotate([180,0,0]) {
                %showPcb();
            }
        }

        lid();
    }
}