function ke = BeamEl(EI, coord)

       % ke = BeamElement(EI, w, coord)
       % Generates equations for a beam element
       % EI = beam stiffness
       % coord = coordinates at the element ends
       
L=coord(2)-coord(1);
ke = [(12*EI)/L^3, (6*EI)/L^2, -((12*EI)/L^3), (6*EI)/L^2;
(6*EI)/L^2, (4*EI)/L, -((6*EI)/L^2), (2*EI)/L;
-((12*EI)/L^3), -((6*EI)/L^2), (12*EI)/L^3, -((6*EI)/L^2);
(6*EI)/L^2, (2*EI)/L, -((6*EI)/L^2), (4*EI)/L];