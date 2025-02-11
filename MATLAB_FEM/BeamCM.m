function m = BeamCM(m_b, coord)
    % BeamConsMass(m_bar, nodes(con,:))
    % Generates mass matrix for a beam element
    % m = Mass per unit length (lb-sec^2/in/in)
     % L = length
    % coord = coordinates at the element ends
L=coord(2)-coord(1);
m = m_b*L/420*[156 22*L 54 -13*L;
22*L 4*L^2 13*L -3*L^2;
54 13*L 156 -22*L;
-13*L -3*L^2 -22*L 4*L^2];