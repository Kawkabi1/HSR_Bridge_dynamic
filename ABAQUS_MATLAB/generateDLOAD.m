function generateDLOAD(Sub_name, d, d0, s, ssp, F, width)  
    % generateDLOAD generates a Fortran subroutine in a specified file based on the given parameters.  
    %  
    % Inputs:  
    %   Sub_name: A string specifying the name of the output Fortran file.  
    %   d       : A vector containing the values for d.  
    %   d0      : A scalar value for d0.  
    %   s       : A scalar value for s.  
    %   ssp     : A scalar value for ssp.  
    %   F       : A scalar variable for the force to be initialized in the Fortran code.  
    
    % Open a file for writing  
    fid = fopen(Sub_name, 'w');  
    
    % Check if the d vector is empty  
    if isempty(d)  
        error('Input vector d cannot be empty.');  
    end  

    % Write the Fortran subroutine header with dynamic subroutine name  
    fprintf(fid, '      SUBROUTINE DLOAD(F,KSTEP,KINC,TIME,NOEL,NPT,LAYER,KSPT,\n', Sub_name);  
    fprintf(fid, '     1 COORDS,JLTYP,SNAME)\n');
    fprintf(fid, 'C\n');  
    fprintf(fid, '      INCLUDE ''ABA_PARAM.INC''\n');  
    fprintf(fid, 'C\n');  
    fprintf(fid, '      DIMENSION TIME(2), COORDS (3)\n');  
    fprintf(fid, '      CHARACTER*80 SNAME\n');  
    
    % Declare the dynamic size for the array d  
    fprintf(fid, '	   REAL, DIMENSION(50) :: d\n');  
    fprintf(fid, '      REAL, DIMENSION(50) :: fa\n');  
    fprintf(fid, '      REAL, DIMENSION(50) :: ra\n');  
    fprintf(fid, '	    real d0, s, sssp, nd, width\n');
    fprintf(fid, '\n');  
    
    % Write the array size for d  
    %fprintf(fid, '      ! Set the size of d array\n');  
    fprintf(fid, '      nd = %d\n', length(d));  
    
    % Initialize d array with individual assignments  
    %fprintf(fid, '      ALLOCATE(d(nd))\n');  
    
    % Write each element of d in the format d(i) = ...  
    for i = 1:length(d)  
        fprintf(fid, '      d(%d) = %.6f\n', i, d(i));  
    end  

    % Write values for d0, s, ssp, and F  
    fprintf(fid, '      d0 = %.6f\n', d0);  
    fprintf(fid, '      s = %.6f\n', s);  
    fprintf(fid, '      ssp = %.6f\n', ssp);  
    fprintf(fid, '      F = 0 \n'); 
    fprintf(fid, '      width = %.6f\n', width);
    fprintf(fid, '\n');  

    % Extract coordinates  
    %fprintf(fid, '      ! Extract coordinates\n');  
    fprintf(fid, '      x = COORDS(1)\n');  
    fprintf(fid, '      y = COORDS(2)\n');  
    fprintf(fid, '      z = COORDS(3)\n');  
    fprintf(fid, '      T = TIME(2)\n');  
    fprintf(fid, '\n');  
    fprintf(fid, '      \n');  
    fprintf(fid, '      \n'); 
    % Main calculation loop  
    %fprintf(fid, '      ! Main calculation loop\n');  
    fprintf(fid, '      DO i = 1, nd\n');  
    fprintf(fid, '        ra(i)=(s*T)-d0-d(i)-(s*0)\n');  
    fprintf(fid, '        fa=(s*T)-d(i)-(s*0)\n');  
    fprintf(fid, '         if (ra(i).LE.sssp .and. fa(i).GE.0) then\n');  
    fprintf(fid, '          if (z.GE.ra(i) .AND. z.LE.fa(i)) then\n');  
    fprintf(fid, '            F = -%.1f/width\n',F);  
    fprintf(fid, '          end if\n');  
    fprintf(fid, '        end if\n');  
    fprintf(fid, '      END DO\n');  
    fprintf(fid, '      \n');  
    fprintf(fid, '      \n');  
    % Clean up and return  
    %fprintf(fid, '      DEALLOCATE(d)\n');  
    fprintf(fid, '      RETURN\n');  
    fprintf(fid, '      END\n', Sub_name);  

    % Close the file  
    fclose(fid);  
    
    %disp(['Fortran subroutine ', Sub_name, ' has been generated.']);  
end