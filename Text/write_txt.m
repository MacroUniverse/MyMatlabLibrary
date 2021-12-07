% write a txt file
cd('C:\Hongyu');
fid = fopen( '123.txt', 'wt' );
fprintf( fid, '%10.9f\n', 3.1415926535);
fclose(fid);
