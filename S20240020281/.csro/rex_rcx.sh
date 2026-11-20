set -e
set -x

rex -dp_comm_string 1,cad6,43399 -V -m -pd -I# -tech /home/install/FOUNDRY/analog/180nm/pv/assura/rcx -map p2elayermapfile -wee p2elayermapfile -N NET -e2 -Ply np_rPOLYterm -rP res.mod -mp mprexaX5N0tm np_rM1term::mt1_cut - rVia1,1,x rPSDcont,1,t rPOLYcont,1,T rNSDcont,1,t - L1T0,1,I

rex -dp_comm_string 2,cad6,43399 -V -m -pd -I# -tech /home/install/FOUNDRY/analog/180nm/pv/assura/rcx -map p2elayermapfile -wee p2elayermapfile -N NET -e2 -Ply np_rPOLYterm -rP res.mod -mp mprexaRB5DmY np_rPOLYterm::poly_cut - PMOS_MOS_27_mgvia,1,z NMOS_MOS_21_mgvia,1,z rPOLYcont,1,x

rex -dp_comm_string 3,cad6,43399 -V -m -pd -I# -tech /home/install/FOUNDRY/analog/180nm/pv/assura/rcx -map p2elayermapfile -wee p2elayermapfile -N NET -e2 -Ply np_rPOLYterm -rP res.mod -mp mprexaXc4keS np_rM2term::mt2_cut - rVia1,1,T

rexmerge -V -N NET -n mprexaRB5DmY,mprexaX5N0tm,mprexaXc4keS -b np_rPOLYterm::Rnp_rPOLYterm.dev2,np_rM1term::Rnp_rM1term.dev2,np_rM2term::Rnp_rM2term.dev2 -l ,L1T0, np_rPOLYterm.res,np_rM1term.res,np_rM2term.res

