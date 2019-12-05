function ParSave(fname,x,y)
if nargin == 3
    save(fname,'x','y');
else
    save(fname,'x');
end