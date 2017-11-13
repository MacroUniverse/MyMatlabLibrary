%两条矢量确定单位法向量
function vlaw=vlaw(v1,v2)
  v=cross(v1,v2);
  vlaw=vunit(v);
end