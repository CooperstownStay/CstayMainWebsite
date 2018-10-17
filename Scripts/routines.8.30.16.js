function availability(host_id){
  for(j=0; j<the_array.length; j++){
    if(host_id == the_array[j][1]){
  status = "Yes";
  break;
    }else{
  status = "No";
    }
  }
  if (status=="No") {
   j=1;
   the_array[j][0]="0000000000000";
  }
date_array = [['June<BR/>3-10'],['June<BR/>10-17'],['June<BR/>17-24'],['June&nbsp;24<BR/>July&nbsp;1'],['July<BR/>1-8'],['July<BR/>8-15'],['July<BR/>15-22'],['July<BR/>22-29'],['July&nbsp;29<BR/>August&nbsp;5'],['August<BR/>5-12'],['August<BR/>12-19'],['August<BR/>19-26'],['August&nbsp;26<BR/>September&nbsp;2']]
date_array2 = [['MYCk5f%2fBq6oYIkQ1Df7rKQ%3d%3d%3adtqL7D6CDbxxyPwKbsUH0Q%3d%3d'],['dtqL7D6CDbxxyPwKbsUH0Q%3d%3d%3aOJ1cbfg7WlM7PynbGHG3ww%3d%3d'],['OJ1cbfg7WlM7PynbGHG3ww%3d%3d%3asUS9HYUCKH9H9wGj83r4bA%3d%3d'],['sUS9HYUCKH9H9wGj83r4bA%3d%3d%3aY8L50lX15878QxAP9zNwJw%3d%3d'],['Y8L50lX15878QxAP9zNwJw%3d%3d%3aswAOHsQ8hWoe9zCmYn7NYw%3d%3d'],['swAOHsQ8hWoe9zCmYn7NYw%3d%3d%3aMxklNVhAUGb1%2fLAIyZoJ%2bQ%3d%3d'],['MxklNVhAUGb1%2fLAIyZoJ%2bQ%3d%3d%3a4rsLkSHIkBTfiRWqH47L4w%3d%3d'],['4rsLkSHIkBTfiRWqH47L4w%3d%3d%3aVaQNNEzXAgy%2b%2bJuc3D734A%3d%3d'],['VaQNNEzXAgy%2b%2bJuc3D734A%3d%3d%3a1Wb2GDO7fdzDP4kMa4on%2fQ%3d%3d'],['1Wb2GDO7fdzDP4kMa4on%2fQ%3d%3d%3aRjjoQl4vl1q1xMz3JYi6hw%3d%3d'],['RjjoQl4vl1q1xMz3JYi6hw%3d%3d%3a9ldKfI%2b9ILIVTjjuxSMMUw%3d%3d'],['9ldKfI%2b9ILIVTjjuxSMMUw%3d%3d%3awJrTXbTquibXR5wZ8SBQWw%3d%3d'],['wJrTXbTquibXR5wZ8SBQWw%3d%3d%3aioP6uVvrnT4X7%2fxj%2bRgG4A%3d%3d']]

  document.write('<table border="0" cellspacing="1" cellpadding="0"><tr>')
  for(i=0; i<date_array.length; i++){
  green = '<td align=center valign=middle width="36" bgcolor="#006600" class="availability">' + date_array[i][0] + '</td>';
  red = '<td align=center valign=middle width="36" bgcolor="#CC0000" class="availability">' + date_array[i][0] + '</td>';
  yellow = '<td align=center valign=middle width="36" bgcolor="#FFCC33" class="availability">' + date_array[i][0] + '</td>';
  if(the_array[j][0].substr(i,1) == 1){
    cell_color = red;
  }else if(the_array[j][0].substr(i,1) == 2){
    cell_color = yellow;
  }else{
    cell_color = green;
  }
  document.write(cell_color) ;
  }
document.write('</tr><tr>')
for(i=0; i<date_array.length; i++){
  green = '<td align=center valign=middle width="36" bgcolor="#006600" class="availability"><a href="#"  onclick="BookItClickIt(' + host_id + ',\'' + escape(date_array2[i][0]) + '\');"><font color="#FFCC33">Book It</font></a></td>';
  red = '<td align=center valign=middle width="36" bgcolor="#CC0000" class="availability"></td>';
  yellow = '<td align=center valign=middle width="36" bgcolor="#FFCC33" class="availability"></td>';
if(the_array[j][0].substr(i,1) == 1){
cell_color = red;
}else if(the_array[j][0].substr(i,1) == 2){
cell_color = yellow;
}else{
cell_color = green;
}
document.write(cell_color) ;
}
  document.write('</tr></table>')
}
