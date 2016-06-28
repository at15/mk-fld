%%
figure
lbh = uicontrol( 'Style', 'Listbox', 'String', {'line1','line2'} );
%%
str = get( lbh, 'String' );
str = cat( 1, {'new line'}, str );
%%
set( lbh, 'String', str )
%%
str{end+1} = 'bottom line';
set( lbh, 'String', str )