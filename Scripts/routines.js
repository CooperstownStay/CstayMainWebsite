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
date_array = [['June<BR/>1-8'],['June<BR/>8-15'],['June<BR/>15-22'],['June<BR/>22-29'],['June&nbsp;29<BR/>July&nbsp;6'],['July<BR/>6-13'],['July<BR/>13-20'],['July<BR/>20-27'],['July&nbsp;27<BR/>August&nbsp;3'],['August<BR/>3-10'],['August<BR/>10-17'],['August<BR/>17-24'],['August<BR/>24-31']]
date_array2 = [['NYT1iAgEIyvMxcDBM3%2bxMQ%3d%3d%3aqBaYLh7ruOTmpLJIBBXR%2bQ%3d%3d'],['qBaYLh7ruOTmpLJIBBXR%2bQ%3d%3d%3aix5fp1%2fMyY4meglMIhCbSw%3d%3d'],['ix5fp1%2fMyY4meglMIhCbSw%3d%3d%3aI%2bkrbcPSkdG%2bZVt95D1pHA%3d%3d'],['I%2bkrbcPSkdG%2bZVt95D1pHA%3d%3d%3a%2fcVSV0X0T48GxbTtBLJgdw%3d%3d'],['%2fcVSV0X0T48GxbTtBLJgdw%3d%3d%3aZoDkFUz5HcUajyzdaNsqzw%3d%3d'],['ZoDkFUz5HcUajyzdaNsqzw%3d%3d%3arjz%2bqzObKCSo6s2ckVblAQ%3d%3d'],['rjz%2bqzObKCSo6s2ckVblAQ%3d%3d%3aOzpANAadOXspxL7BJAp2ig%3d%3d'],['OzpANAadOXspxL7BJAp2ig%3d%3d%3atqJz4Hcf4gfVW%2fMzxXnYEg%3d%3d'],['tqJz4Hcf4gfVW%2fMzxXnYEg%3d%3d%3aUG4Cctv8Mz%2bxzZxOEH8iZg%3d%3d'],['UG4Cctv8Mz%2bxzZxOEH8iZg%3d%3d%3aNQzVAIVzbRAmrBnpWa5Zeg%3d%3d'],['NQzVAIVzbRAmrBnpWa5Zeg%3d%3d%3a2zjsvhpooN%2b7%2bV3V5v1awQ%3d%3d'],['2zjsvhpooN%2b7%2bV3V5v1awQ%3d%3d%3aLBOkO5YKdlKPXBOWcuRgwg%3d%3d'],['LBOkO5YKdlKPXBOWcuRgwg%3d%3d%3aI%2bxK%2fkReilxURMXdbBpuPQ%3d%3d']]

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
  green = '<td align=center valign=middle width="36" bgcolor="#006600" class="availability"><a href="https://secure.Cstayreserve.com/Reserve.aspx?PropID=' + host_id + '&Week=' + date_array2[i][0] + '"  ><font color="#FFCC33">Book</font></a></td>';
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
