%%%
  VERSION:1
  LANGUAGE:ENGLISH
%%%

MODULE p0001
  PERS num nPos:=1;
  CONST num nInterlay:=175;
  PERS num nDegToAddC1:=-1.8;
  PERS num nDegToAddC2:=-2;
  PERS num nDeg:=0;
  PERS num nDegTmp:=18.7562;
  PERS bool xFirstCicle:=FALSE;
  PERS num nMission:=0;
  PERS num nPosDepOut:=1;
  VAR robtarget pTempDep;
  VAR robtarget pTempOut;
  VAR robtarget pTemp;
  VAR robtarget PTempEXIT;
  PERS num nDeposito:=1;
  PERS loaddata nWeight:=[10,[0,0,1],[1,0,0,0],0,0,0];
  CONST bool bDryRun:=FALSE;
  CONST num nShiftLevel1:=150;
  CONST num nShiftLevel2:=300;
  CONST num nDeltaXC1:=0.5;
  CONST num nDeltaZC1:=0.25;
  CONST num nDeltaXC2:=0.5;
  CONST num nDeltaZC2:=-0.3;
  !*****************************************************************************************************************************************************
  !                                               PUNTI MASTER PER PICK & DROP SUI CARRI                                                               !
  !*****************************************************************************************************************************************************
  CONST robtarget pPrelMaster_A:=[[234.37,56.8,47.63],[0.174068,0.984681,-0.007798,-0.007218],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPrelMaster_A1:=[[781.98,85.31,139.3],[0.002825,0.003651,0.972279,-0.233778],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPrelMaster_B:=[[273.58,54.51,-51.29],[0.006867,-0.005969,0.216231,-0.9763],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPrelMaster_B1:=[[757.91,85.45,-138.84],[0.971316,0.237642,0.008459,-0.0014],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDepMaster_B:=[[292.43,52.17,-52.37],[0.986588,0.162939,-0.001775,-0.009562],[-1,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDepMaster_B1:=[[762.33,86.1,-139.42],[0.001801,0.00583,-0.215774,0.976425],[-1,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDepMaster_A:=[[258.88,54.01,53.53],[0.008011,0.001791,-0.981285,0.192411],[0,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDepMaster_A1:=[[774.95,86.86,141.41],[0.230304,0.973093,0.00717,0.000221],[0,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  !*****************************************************************************************************************************************************
  !*****************************************************************************************************************************************************
  CONST robtarget pDepCNC:=[[321.35,2540.35,556.81],[0.002978,-0.999941,0.000414,0.01045],[0,-1,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPrelCNC:=[[322.89,2537.88,553.34],[0.001185,0.000431,0.999998,0.001775],[0,-1,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDepMeas:=[[1511.59,15.0167,676.231],[0.0111656,0.00690202,-0.999819,-0.0138088],[-1,-4,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPreMeas:=[[1511.59,15.0167,676.231],[0.0111656,0.00690202,-0.999819,-0.0138088],[-1,-4,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDepOutM1:=[[2081.12,-1228.98,101.05],[0.081522,-0.692709,-0.7104,0.094025],[-1,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDepOutM2:=[[1916.49,-1228.98,101.05],[0.180105,-0.673746,-0.68944,0.195711],[-1,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDepOutM3:=[[1645.25,-1228.98,101.05],[0.232379,-0.657548,-0.671971,0.24917],[-1,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDepIsp:=[[-2156.93,-1273.44,1003.18],[0.011052,-0.712327,0.701752,-0.00362],[-2,-2,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDepScarto:=[[-2163.13,-1286.64,1001.18],[0.009811,0.706617,0.707517,0.004068],[-2,-2,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPrelIsp:=[[-2156.65,-1264.85,1000.51],[0.012635,-0.70644,0.70766,-0.001211],[-2,-2,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPrelOutC1:=[[484.97,974.24,760.52],[0.17366,0.984752,-0.00748,-0.007706],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPrelOutC2:=[[492.28,1103.19,-755.29],[0.004606,0.004233,0.216838,-0.976188],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST jointtarget jSvincIsp:=[[-4.12,-54.48,39.35,-93.39,70.27,88.09],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget DepOutPos:=[[2104.57,-1246.17,584.67],[0.166272,0.687245,-0.688732,-0.160303],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  !Punti soffiaggio in uso
  LOCAL CONST robtarget prSoffDX:=[[528.13,2381.34,808.44],[0.00114,0.000419,0.999998,0.001806],[0,-1,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  LOCAL CONST robtarget prSoffSX:=[[173.46,2381.34,789.67],[0.001138,0.000416,0.999998,0.001807],[0,-1,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

  !************************************************************************************************************************************************
  !                                                                                                                                               !
  !                                                                                                                                               !
  !----------------------------------------------            MODELLO 314661ADT1 (LUNGO)             ----------------------------------------------!                                                                             !
  !                                                                                                                                               !
  !                                                                                                                                               !
  !************************************************************************************************************************************************
  PROC Scarto()
    !
    !Controllo pinza carica
    WaitUntil diGrpAPartPres=1;
    !
    MoveRAbsJ jFronteIsp,v1000,z100,tPinzaA\WObj:=wRowDX;
    Reset doOutIsp;
    MoveRAbsJ [[-105,-5.17,33.52,-96.28,76.22,-61.76],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],v1000,z100,tPinzaA;
    MoveRL RelTool(pDepScarto,0,0,-150),v500,z50,tPinzaA\WObj:=wobj0;
    bInArea:=TRUE;
    MoveL pDepScarto,v200,fine,tPinzaA\WObj:=wobj0;
    !
    !Apertura Pinza A
    GrpAOpen;
    CtrlPzANotPres;
    WaitTime 1;
    !
    MoveRL RelTool(pDepScarto,0,0,-150),v500,z50,tPinzaA\WObj:=wobj0;
    MoveRAbsJ [[-105,-5.17,33.52,-96.28,76.22,-61.76],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],v1000,z100,tPinzaA;
    bInArea:=FALSE;
    MoveRAbsJ jFronteIsp,v1000,z100,tPinzaA\WObj:=wRowDX;
    PosRec_Clear;
    Set doOutIsp;
    !
  ENDPROC

  PROC PrelCarro1()
    IF FALSE THEN
      MoveRL pPrelMaster_A,v1000,fine,tPinzaA\WObj:=wRowSX;
      MoveRL pPrelMaster_A1,v1000,fine,tPinzaA\WObj:=wRowSX;
    ENDIF
    ConfL\Off;
    !    
    CalPrelC1Singolo;
    !
    !Controllo pinza scarica
    WaitUntil diGrpAPartPres=0;
    PulseDO\High\PLength:=0.5,doReqGrpAOpen;
    !
    MoveRAbsJ jFronteC1,v1000,z200,tPinzaA;
    MoveRAbsJ jApp_A,v1000,z200,tPinzaA;
    MoveRL pPrelOutC1,v500,z100,tPinzaA\WObj:=wRowSX;
    bInAreaPick:=TRUE;
    MoveRL RelTool(pTemp,0,0,-100),v1000,fine,tPinzaA\WObj:=wRowSX;
    MoveL pTemp,v100,fine,tPinzaA\WObj:=wRowSX;
    !
    !Chiusura Pinza A
    GrpAClose;
    CtrlPzAPres;
    WaitTime 1;
    !
    PTempEXIT:=CRobT(\Tool:=tPinzaA\WObj:=wRowSX);
    PTempEXIT:=Offs(PTempEXIT,0,0,100);
    MoveRL PTempEXIT,v100,z50,tPinzaA\WObj:=wRowSX;
    !MoveRL pPrelOutC1,v500,z100,tPinzaA\WObj:=wRowSX;
    !posizione controllo pezzo
    MoveL [[388.97,2240.56,957.11],[0.173577,0.984767,-0.007474,-0.007708],[1,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],v500,fine,tPinzaA\WObj:=wRowSX;
    WaitTime 2;
    Set doStartPartCtrl;
    WaitUntil diEndPartCtrl=1;
    Reset doStartPartCtrl;
    bInAreaPick:=FALSE;
    MoveRL pPrelOutC1,v500,z100,tPinzaA\WObj:=wRowSX;
    MoveRAbsJ jApp_A,v1000,z200,tPinzaA;
    PosRec_Clear;
    MoveAbsJ jFronteC1,v1000,z200,tPinzaA;
  ENDPROC

  PROC PrelCarro2()
    IF FALSE THEN
      MoveRL pPrelMaster_B,v1000,fine,tPinzaA\WObj:=wRowDX;
      MoveRL pPrelMaster_B1,v1000,fine,tPinzaA\WObj:=wRowDX;
    ENDIF
    ConfL\Off;
    !
    CalPrelC2Singolo;
    !
    !Controllo pinza scarica
    WaitUntil diGrpAPartPres=0;
    PulseDO\High\PLength:=0.5,doReqGrpAOpen;
    !
    MoveRAbsJ jFronteC2,v1000,z100,tPinzaA\WObj:=wRowDX;
    MoveRAbsJ jApp_B,v1000,z100,tPinzaA\WObj:=wRowDX;
    MoveRL pPrelOutC2,v500,z100,tPinzaA\WObj:=wRowDX;
    bInAreaPick:=TRUE;
    MoveRL RelTool(pTemp,0,0,-150),v1000,fine,tPinzaA\WObj:=wRowDX;
    MoveL pTemp,v100,fine,tPinzaA\WObj:=wRowDX;
    !
    !Chiusura Pinza A
    GrpAClose;
    CtrlPzAPres;
    WaitTime 1;
    !
    PTempEXIT:=CRobT(\Tool:=tPinzaA\WObj:=wRowDX);
    PTempEXIT:=Offs(PTempEXIT,0,0,-100);
    MoveRL PTempEXIT,v100,z50,tPinzaA\WObj:=wRowDX;
    !MoveRL pPrelOutC2,v500,z100,tPinzaA\WObj:=wRowDX;
    !posizione controllo pezzo
    MoveL [[564.06,684.21,-485.95],[0.004598,0.00425,0.216838,-0.976188],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],v500,fine,tPinzaA\WObj:=wRowDX;
    WaitTime 2;
    Set doStartPartCtrl;
    WaitUntil diEndPartCtrl=1;
    Reset doStartPartCtrl;
    bInAreaPick:=FALSE;
    MoveRAbsJ jApp_B,v1000,z100,tPinzaA\WObj:=wRowDX;
    MoveRAbsJ jFronteC2,v1000,z100,tPinzaA\WObj:=wRowDX;
    MoveRAbsJ jFronteC1,v1000,z100,tPinzaA\WObj:=wRowDX;
    PosRec_Clear;
  ENDPROC

  PROC DepCNC()
    !
    !Controllo pinza carica
    WaitUntil diGrpAPartPres=1;
    !
    MoveRAbsJ jFronteC1,v1000,z200,tPinzaA;
    MoveRAbsJ jAppDepCNC,v1000,z100,tPinzaA\WObj:=wobj0;
    bInArea:=TRUE;
    !
    !Robot in ingombro
    Reset doOutCnc;
    !
    MoveRL RelTool(pDepCNC,0,0,-150),v500,z100,tPinzaA\WObj:=wobj0;
    ! Appoggio pezzo al puntalino
    MoveRL pDepCNC,v100,fine,tPinzaA\WObj:=wobj0;
    SoftAct 1,40;
    SoftAct 2,40;
    SoftAct 3,40;
    SoftAct 4,40;
    SoftAct 5,40;
    SoftAct 6,40;
    MoveRL Offs(pDepCNC,-20,0,0),v10,fine,tPinzaA\WObj:=wobj0;
    !
    !Apertura Pinza A
    IF diSelMorsa=1 THEN
      Ctrl_CloseCNC;
    ENDIF
    pTempDep:=CRobT(\Tool:=tPinzaA\WObj:=wobj0);
    MoveL pTempDep,v100,fine,tPinzaA\WObj:=wobj0;
    SoftDeact;
    !
    GrpAOpen;
    CtrlPzANotPres;
    WaitTime 1;
    PulseDO\High\PLength:=0.5,doPzDep;
    !				   
    MoveRL RelTool(pDepCNC,0,0,-150),v500,z100,tPinzaA\WObj:=wobj0;
    MoveRAbsJ jAppDepCNC,v500,z100,tPinzaA\WObj:=wobj0;
    MoveRAbsJ jFronteC1,v1000,fine,tPinzaA;
    PosRec_Clear;
    bInArea:=FALSE;
    !
    !Robot fuori ingombro
    Set doOutCnc;
    !
  ENDPROC

  PROC PrelCNC()
    !
    !Controllo pinza scarica
    WaitUntil diGrpBPartPres=0;
    PulseDO\High\PLength:=0.5,doReqGrpBOpen;
    !
    MoveRAbsJ jFronteC1,v1000,z200,tPinzaA;
    MoveRAbsJ jAppPrelCNC,v1000,z100,tPinzaB\WObj:=wobj0;
    bInArea:=TRUE;
    !
    !Robot in ingombro
    Reset doOutCnc;
    !
    MoveRL RelTool(pPrelCNC,0,0,-150),v500,z100,tPinzaB\WObj:=wobj0;
    MoveL pPrelCNC,v500,fine,tPinzaB\WObj:=wobj0;
    !
    !Chiusura Pinza B
    GrpBClose;
    Ctrl_OpenCNC;
    CtrlPzBPres;
    WaitTime 1;
    PulseDO\High\PLength:=0.5,doPzPrel;
    !
    MoveRL RelTool(pPrelCNC,-15,0,-150),v500,z100,tPinzaB\WObj:=wobj0;
    !*************************************
    !Soffiaggio in uso
    MoveRL Offs(prSoffDX,-100,0,0),v200,z50,tPinzaB\WObj:=wobj0;
    MoveRL prSoffDX,v200,fine,tPinzaB\WObj:=wobj0;
    Set do_Soffia1;
    WaitTime 2;
    Reset do_Soffia1;
    MoveL Offs(prSoffDX,-100,0,0),v200,z50,tPinzaB\WObj:=wobj0;
    MoveL prSoffSX,v200,fine,tPinzaB\WObj:=wobj0;
    Set do_Soffia2;
    WaitTime 2;
    Reset do_Soffia2;
    MoveL Offs(prSoffSX,100,0,0),v200,z50,tPinzaB\WObj:=wobj0;
    !************************************* 
    MoveRAbsJ jAppPrelCNC,v500,z100,tPinzaB\WObj:=wobj0;
    MoveRAbsJ jFronteC1,v1000,fine,tPinzaA;
    PosRec_Clear;
    bInArea:=FALSE;
    !
    !Robot fuori ingombro
    Set doOutCnc;
    !
  ENDPROC

  PROC DepCarro1()
    IF FALSE THEN
      MoveRL pDepMaster_A,v1000,z100,tPinzaB\WObj:=wRowSX;
      MoveRL pDepMaster_A1,v1000,z100,tPinzaB\WObj:=wRowSX;
    ENDIF
    ConfL\Off;
    !
    CalDepC1Singolo;
    !
    !Controllo pinza carica
    WaitUntil diGrpBPartPres=1;
    !
    MoveRAbsJ jFronteC1,v1000,z200,tPinzaA;
    MoveRAbsJ jApp_A_Dep,v1000,z100,tPinzaB\WObj:=wobj0;
    bInAreaDrop:=TRUE;
    MoveRL Offs(pTemp,0,0,100),v1000,fine,tPinzaB\WObj:=wRowSX;
    MoveL pTemp,v100,fine,tPinzaB\WObj:=wRowSX;
    !
    !Apertura Pinza B
    GrpBOpen;
    CtrlPzBNotPres;
    WaitTime 1;
    !
    MoveRL RelTool(pTemp,0,0,-150),v1000,z200,tPinzaB\WObj:=wRowSX;
    MoveRL [[471.8,1221.74,913.23],[0.000585,-0.023252,-0.968995,0.246004],[0,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],v1000,z50,tPinzaB\WObj:=wRowSX;
    MoveRAbsJ jApp_A_Dep,v1000,z100,tPinzaB\WObj:=wobj0;
    MoveRAbsJ jFronteC1,v1000,z200,tPinzaA;
    PosRec_Clear;
    bInAreaDrop:=FALSE;
  ENDPROC

  PROC DepCarro2()
    IF FALSE THEN
      MoveRL pDepMaster_B,v1000,z100,tPinzaB\WObj:=wRowDX;
      MoveRL pDepMaster_B1,v1000,z100,tPinzaB\WObj:=wRowDX;
    ENDIF
    ConfL\Off;
    !
    CalDepC2Singolo;
    !
    !Controllo pinza carica
    WaitUntil diGrpBPartPres=1;
    !
    MoveRAbsJ jFronteC2,v1000,z100,tPinzaA\WObj:=wRowDX;
    MoveRAbsJ jApp_B_Dep,v1000,z100,tPinzaB\WObj:=wobj0;
    bInAreaDrop:=TRUE;
    MoveRL Offs(pTemp,0,0,-100),v1000,fine,tPinzaB\WObj:=wRowDX;
    MoveL pTemp,v100,fine,tPinzaB\WObj:=wRowDX;
    !
    !Apertura Pinza B
    GrpBOpen;
    CtrlPzBNotPres;
    WaitTime 1;
    !
    MoveRL RelTool(pTemp,0,0,-150),v1000,z200,tPinzaB\WObj:=wRowDX;
    MoveRL [[433.88,1245.15,-1025.78],[0.976406,0.215726,0.006395,0.007219],[-1,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],v1000,z50,tPinzaB\WObj:=wRowDX;
    MoveRAbsJ jApp_B_Dep,v1000,z100,tPinzaB\WObj:=wobj0;
    MoveRAbsJ jFronteC2,v1000,z100,tPinzaA\WObj:=wRowDX;
    PosRec_Clear;
    bInAreaDrop:=FALSE;
  ENDPROC

  PROC DepMeasure()
    ConfL\Off;
    !
    !Controllo pinza carica
    WaitUntil diGrpBPartPres=1;
    !
    MoveRAbsJ jAppMeas,v1000,z100,tPinzaB\WObj:=wobj0;
    !
    !Robot in ingombro
    Reset doOutMisura;
    !
    MoveRJ pWayToDep,v500,z100,tPinzaB\WObj:=wobj0;
    bInArea:=TRUE;
    MoveRL RelTool(pDepMeas,50,0,-150),v500,z100,tPinzaB\WObj:=wobj0;
    MoveL pDepMeas,v200,fine,tPinzaB\WObj:=wobj0;
    !
    !Apertura Pinza B
    GrpBOpen;
    CtrlPzBNotPres;
    WaitTime 1;
    !
    MoveRL RelTool(pDepMeas,0,0,-150),v500,z100,tPinzaB\WObj:=wobj0;
    MoveRJ pWayToDep,v500,z100,tPinzaB\WObj:=wobj0;
    MoveRAbsJ jAppMeas,v1000,z100,tPinzaB\WObj:=wobj0;
    PosRec_Clear;
    bInArea:=FALSE;
    !
    !Robot fuori ingombro
    Set doOutMisura;
    !
  ENDPROC

  PROC DepIsp()
    !
    !Controllo pinza carica
    WaitUntil diGrpBPartPres=1;
    !
    MoveRAbsJ jFronteIsp,v1000,z100,tPinzaA\WObj:=wRowDX;
    Reset doOutIsp;
    MoveRAbsJ jAppIsp,v1000,z100,tPinzaB\WObj:=wobj0;
    MoveRL RelTool(pDepIsp,0,0,-150),v500,z50,tPinzaB\WObj:=wobj0;
    bInArea:=TRUE;
    MoveL pDepIsp,v200,fine,tPinzaB\WObj:=wobj0;
    !
    !Apertura Pinza B
    GrpBOpen;
    CtrlPzBNotPres;
    WaitTime 1;
    !
    MoveRL RelTool(pDepIsp,0,0,-150),v500,z50,tPinzaB\WObj:=wobj0;
    MoveRAbsJ jAppIsp,v1000,z100,tPinzaB\WObj:=wobj0;
    bInArea:=FALSE;
    MoveRAbsJ jFronteIsp,v1000,z100,tPinzaA\WObj:=wRowDX;
    PosRec_Clear;
    Set doOutIsp;
  ENDPROC

  PROC PrelIsp()
    ConfL\Off;
    !
    !Controllo pinza scarica
    WaitUntil diGrpBPartPres=0;
    PulseDO\High\PLength:=0.5,doReqGrpBOpen;
    !
    MoveRAbsJ jFronteIsp,v1000,z100,tPinzaA\WObj:=wRowDX;
    Reset doOutIsp;
    MoveRAbsJ jAppIsp,v1000,z100,tPinzaB\WObj:=wobj0;
    MoveRL RelTool(pPrelIsp,0,0,-150),v500,z50,tPinzaB\WObj:=wobj0;
    bInArea:=TRUE;
    MoveL pPrelIsp,v200,fine,tPinzaB\WObj:=wobj0;
    !
    !Chiusura Pinza B
    GrpBClose;
    CtrlPzBPres;
    WaitTime 1;
    !
    MoveRL RelTool(pPrelIsp,0,0,-150),v500,z50,tPinzaB\WObj:=wobj0;
    MoveRAbsJ jAppIsp,v1000,z100,tPinzaB\WObj:=wobj0;
    bInArea:=FALSE;
    MoveRAbsJ jFronteIsp,v1000,z100,tPinzaA\WObj:=wRowDX;
    PosRec_Clear;
    Set doOutIsp;
  ENDPROC

  PROC PrelMeasure()
    ConfL\Off;
    !
    !Controllo pinza scarica
    WaitUntil diGrpBPartPres=0;
    PulseDO\High\PLength:=0.5,doReqGrpBOpen;
    !
    MoveRAbsJ jAppMeas,v1000,z100,tPinzaB\WObj:=wobj0;
    MoveRJ pWayToPrel,v500,z100,tPinzaB\WObj:=wobj0;
    bInArea:=TRUE;
    MoveRL RelTool(pPreMeas,0,0,-150),v500,z100,tPinzaB\WObj:=wobj0;
    MoveL pPreMeas,v200,fine,tPinzaB\WObj:=wobj0;
    !
    !Chiusura Pinza B
    GrpBClose;
    CtrlPzBPres;
    WaitTime 1;
    !
    MoveRL RelTool(pPreMeas,50,0,-150),v500,z100,tPinzaB\WObj:=wobj0;
    MoveRJ pWayToPrel,v500,z100,tPinzaB\WObj:=wobj0;
    MoveRAbsJ jAppMeas,v1000,z100,tPinzaB\WObj:=wobj0;
    PosRec_Clear;
    bInArea:=FALSE;
  ENDPROC

  PROC DepOUT()
    IF FALSE THEN
      MoveRL pDepOutM1,v1000,fine,tPinzaB\WObj:=wobj0;
      MoveRL pDepOutM2,v1000,fine,tPinzaB\WObj:=wobj0;
      MoveRL pDepOutM3,v1000,fine,tPinzaB\WObj:=wobj0;
    ENDIF
    !IF diResetBin=1 THEN
    ! nPosDepOut:=1;
    ! PulseDO doAckBin;
    ! WaitUntil diResetBin=0;
    !ENDIF
    ConfL\Off;
    GetPosOut;
    !
    !Controllo pinza carica
    WaitUntil diGrpBPartPres=1;
    !
    MoveRAbsJ jFronteOUT,v1000,z100,tPinzaA\WObj:=wRowDX;
    MoveRAbsJ jAppDepOut,v1000,z100,tPinzaB\WObj:=wobj0;
    MoveRAbsJ jOverBin,v1000,z100,tPinzaB\WObj:=wobj0;
    bInArea:=TRUE;
    MoveRL Offs(pTempOut,0,0,50),v500,z10,tPinzaB\WObj:=wobj0;
    MoveL pTempOut,v200,fine,tPinzaB\WObj:=wobj0;
    !
    !Apertura Pinza B
    GrpBOpen;
    CtrlPzBNotPres;
    WaitTime 1;
    !
    MoveRAbsJ jOverBin,v1000,z100,tPinzaB\WObj:=wobj0;
    MoveRAbsJ jAppDepOut,v1000,z100,tPinzaB\WObj:=wobj0;
    MoveRAbsJ jFronteOUT,v1000,z100,tPinzaA\WObj:=wRowDX;
    Incr nPosDepOut;
    IF nPosDepOut=4 THEN
      nPosDepOut:=1;
    ENDIF
    PosRec_Clear;
    bInArea:=FALSE;
    !Incr nPosDepOut;
    !IF nPosDepOut>21 THEN
    !TPErase;
    !TPWrite "Cassone Pieno";
    !Stop;
    !ENDIF
  ENDPROC

  PROC GetPosOut()
    CONST num nInterlay_Z:=10;

    nDeposito:=nPosDepOut;
    TEST nDeposito
    CASE 1:
      pTempOut:=pDepOutM1;
      IF giLevelDrop=1 THEN
        pTempOut:=pDepOutM1;
        pTempOut.trans.z:=pTempOut.trans.z+(nShiftLevel1);
      ENDIF
      IF giLevelDrop=2 THEN
        pTempOut:=pDepOutM1;
        pTempOut.trans.z:=pTempOut.trans.z+(nShiftLevel2);
      ENDIF
    CASE 2:
      pTempOut:=pDepOutM2;
      IF giLevelDrop=1 THEN
        pTempOut:=pDepOutM2;
        pTempOut.trans.z:=pTempOut.trans.z+(nShiftLevel1);
      ENDIF
      IF giLevelDrop=2 THEN
        pTempOut:=pDepOutM2;
        pTempOut.trans.z:=pTempOut.trans.z+(nShiftLevel2);
      ENDIF
    CASE 3:
      pTempOut:=pDepOutM3;
      IF giLevelDrop=1 THEN
        pTempOut:=pDepOutM3;
        pTempOut.trans.z:=pTempOut.trans.z+(nShiftLevel1);
      ENDIF
      IF giLevelDrop=2 THEN
        pTempOut:=pDepOutM3;
        pTempOut.trans.z:=pTempOut.trans.z+(nShiftLevel2);
      ENDIF
    ENDTEST
  ENDPROC

  PROC CalPrelC1Doppio()
    VAR num nAngX:=0;
    VAR num nAngY:=0;
    VAR num nAngZ:=0;

    IF giC1Pick<=20 THEN
      nPosPick:=giC1Pick;
      pTemp:=pPrelMaster_A;
      pTemp.trans.x:=pTemp.trans.x+((nPosPick-1)*nDeltaXC1);
      pTemp.trans.y:=pTemp.trans.y+((nPosPick-1)*nInterlay);
      pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC1);
      nDeg:=Abs(nDegToAddC1*(nPosPick-1));
      nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
      nAngX:=EulerZYX(\X,pTemp.rot);
      nAngY:=EulerZYX(\Y,pTemp.rot);
      nAngZ:=EulerZYX(\Z,pTemp.rot);
      pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
    ELSE
      nPosPick:=giC1Pick-20;
      pTemp:=pPrelMaster_A1;
      pTemp.trans.x:=pTemp.trans.x+((nPosPick-1)*nDeltaXC1);
      pTemp.trans.y:=pTemp.trans.y+((nPosPick-1)*nInterlay);
      pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC1);
      nDeg:=Abs(nDegToAddC1*(nPosPick-1));
      nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
      nAngX:=EulerZYX(\X,pTemp.rot);
      nAngY:=EulerZYX(\Y,pTemp.rot);
      nAngZ:=EulerZYX(\Z,pTemp.rot);
      pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
      !
    ENDIF
  ENDPROC

  PROC CalDepC1Doppio()
    VAR num nAngX:=0;
    VAR num nAngY:=0;
    VAR num nAngZ:=0;

    IF giC1Drop<=20 THEN
      nPosDrop:=giC1Drop;
      pTemp:=pDepMaster_A;
      pTemp.trans.y:=pTemp.trans.y+((nPosDrop-1)*nInterlay);
      pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC1);
      nDeg:=nDegToAddC1*(nPosDrop-1);
      nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
      nAngX:=EulerZYX(\X,pTemp.rot);
      nAngY:=EulerZYX(\Y,pTemp.rot);
      nAngZ:=EulerZYX(\Z,pTemp.rot);
      pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
    ELSE
      nPosDrop:=giC1Drop-20;
      pTemp:=pDepMaster_A1;
      pTemp.trans.y:=pTemp.trans.y+((nPosDrop-1)*nInterlay);
      pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC1);
      nDeg:=nDegToAddC1*(nPosDrop-1);
      nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
      nAngX:=EulerZYX(\X,pTemp.rot);
      nAngY:=EulerZYX(\Y,pTemp.rot);
      nAngZ:=EulerZYX(\Z,pTemp.rot);
      pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
      !
    ENDIF
  ENDPROC

  PROC CalPrelC1Singolo()
    VAR num nAngX:=0;
    VAR num nAngY:=0;
    VAR num nAngZ:=0;

    nPosPick:=giC1Pick;
    pTemp:=pPrelMaster_A;
    pTemp.trans.x:=pTemp.trans.x+((nPosPick-1)*nDeltaXC1);
    pTemp.trans.y:=pTemp.trans.y+((nPosPick-1)*nInterlay);
    pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC1);
    nDeg:=Abs(nDegToAddC1*(nPosPick-1));
    nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
    nAngX:=EulerZYX(\X,pTemp.rot);
    nAngY:=EulerZYX(\Y,pTemp.rot);
    nAngZ:=EulerZYX(\Z,pTemp.rot);
    pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
  ENDPROC

  PROC CalPrelC2Singolo()
    VAR num nAngX:=0;
    VAR num nAngY:=0;
    VAR num nAngZ:=0;

    nPosPick:=giC2Pick;
    pTemp:=pPrelMaster_B;
    pTemp.trans.x:=pTemp.trans.x+((nPosPick-1)*nDeltaXC2);
    pTemp.trans.y:=pTemp.trans.y+((nPosPick-1)*nInterlay);
    pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC2);
    nDeg:=Abs(nDegToAddC2*(nPosPick-1));
    nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
    nAngX:=EulerZYX(\X,pTemp.rot);
    nAngY:=EulerZYX(\Y,pTemp.rot);
    nAngZ:=EulerZYX(\Z,pTemp.rot);
    pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
  ENDPROC

  PROC CalDepC2Singolo()
    VAR num nAngX:=0;
    VAR num nAngY:=0;
    VAR num nAngZ:=0;

    nPosDrop:=giC2Drop;
    pTemp:=pDepMaster_B;
    pTemp.trans.y:=pTemp.trans.y+((nPosDrop-1)*nInterlay);
    pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC2);
    nDeg:=nDegToAddC2*(nPosDrop-1);
    nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
    nAngX:=EulerZYX(\X,pTemp.rot);
    nAngY:=EulerZYX(\Y,pTemp.rot);
    nAngZ:=EulerZYX(\Z,pTemp.rot);
    pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
  ENDPROC

  PROC CalDepC1Singolo()
    VAR num nAngX:=0;
    VAR num nAngY:=0;
    VAR num nAngZ:=0;

    nPosDrop:=giC1Drop;
    pTemp:=pDepMaster_A;
    pTemp.trans.y:=pTemp.trans.y+((nPosDrop-1)*nInterlay);
    pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC1);
    nDeg:=nDegToAddC1*(nPosDrop-1);
    nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
    nAngX:=EulerZYX(\X,pTemp.rot);
    nAngY:=EulerZYX(\Y,pTemp.rot);
    nAngZ:=EulerZYX(\Z,pTemp.rot);
    pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
  ENDPROC

  PROC CalPrelC2Doppio()
    VAR num nAngX:=0;
    VAR num nAngY:=0;
    VAR num nAngZ:=0;

    IF giC2Pick<=17 THEN
      nPosPick:=giC2Pick;
      pTemp:=pPrelMaster_B;
      pTemp.trans.x:=pTemp.trans.x+((nPosPick-1)*nDeltaXC2);
      pTemp.trans.y:=pTemp.trans.y+((nPosPick-1)*nInterlay);
      pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC2);
      nDeg:=Abs(nDegToAddC2*(nPosPick-1));
      nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
      nAngX:=EulerZYX(\X,pTemp.rot);
      nAngY:=EulerZYX(\Y,pTemp.rot);
      nAngZ:=EulerZYX(\Z,pTemp.rot);
      pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
    ELSE
      nPosPick:=giC2Pick-17;
      pTemp:=pPrelMaster_B1;
      pTemp.trans.x:=pTemp.trans.x+((nPosPick-1)*nDeltaXC2);
      pTemp.trans.y:=pTemp.trans.y+((nPosPick-1)*nInterlay);
      pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC2);
      nDeg:=Abs(nDegToAddC2*(nPosPick-1));
      nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
      nAngX:=EulerZYX(\X,pTemp.rot);
      nAngY:=EulerZYX(\Y,pTemp.rot);
      nAngZ:=EulerZYX(\Z,pTemp.rot);
      pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
      !
    ENDIF
  ENDPROC

  PROC CalDepC2Doppio()
    VAR num nAngX:=0;
    VAR num nAngY:=0;
    VAR num nAngZ:=0;

    IF giC2Drop<=17 THEN
      nPosDrop:=giC2Drop;
      pTemp:=pDepMaster_B;
      pTemp.trans.y:=pTemp.trans.y+((nPosDrop-1)*nInterlay);
      pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC2);
      nDeg:=nDegToAddC2*(nPosDrop-1);
      nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
      nAngX:=EulerZYX(\X,pTemp.rot);
      nAngY:=EulerZYX(\Y,pTemp.rot);
      nAngZ:=EulerZYX(\Z,pTemp.rot);
      pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
    ELSE
      nPosDrop:=giC2Drop-17;
      pTemp:=pDepMaster_B1;
      pTemp.trans.y:=pTemp.trans.y+((nPosDrop-1)*nInterlay);
      pTemp.trans.z:=pTemp.trans.z+((nPosPick-1)*nDeltaZC2);
      nDeg:=nDegToAddC2*(nPosDrop-1);
      nDegTmp:=EulerZYX(\X,pTemp.rot)+nDeg;
      nAngX:=EulerZYX(\X,pTemp.rot);
      nAngY:=EulerZYX(\Y,pTemp.rot);
      nAngZ:=EulerZYX(\Z,pTemp.rot);
      pTemp.rot:=OrientZYX(nAngZ,nAngY,nDegTmp);
      !
    ENDIF
  ENDPROC

  !**********************************************************************
  !*********************** Gestione Gripper A - B ***********************  
  !**********************************************************************    
  PROC GrpAClose()
    Set doReqGrpAClose;
    WaitUntil diGrpAPartPres=1;
    Reset doReqGrpAClose;
    GripLoad nWeight;
  ENDPROC

  PROC GrpAOpen()
    Set doReqGrpAOpen;
    WaitUntil diGrpAPartPres=0;
    Reset doReqGrpAOpen;
    GripLoad load0;
  ENDPROC

  PROC GrpBClose()
    Set doReqGrpBClose;
    WaitUntil diGrpBPartPres=1;
    Reset doReqGrpBClose;
    GripLoad nWeight;
  ENDPROC

  PROC GrpBOpen()
    Set doReqGrpBOpen;
    WaitUntil diGrpBPartPres=0;
    Reset doReqGrpBOpen;
    GripLoad load0;
  ENDPROC

  PROC Ctrl_CloseCNC()
    IF diStCloseMorsa=0 THEN
      Set doReqCloseMorsa;
      WaitDI diStCloseMorsa,1;
      Reset doReqCloseMorsa;
    ENDIF
  ENDPROC

  PROC Ctrl_OpenCNC()
    IF diStOpenMorsa=0 THEN
      Set doReqOpenMorsa;
      WaitDI diStOpenMorsa,1;
      Reset doReqOpenMorsa;
    ENDIF
  ENDPROC

  ! ### CONTROLLI ###
  PROC CtrlPzAPres()
    IF NOT bDryRun THEN
      WaitDI diGrpAPartPres,1\MaxTime:=2;
    ENDIF
    !
    ! ERROR
    ! IF ERRNO=ERR_WAIT_MAXTIME THEN
    !  Set do_CustomErr;
    ! SetGO go_ErrNo,1;
    ! TRYNEXT;
    !
    !ENDIF
    !
  ENDPROC

  PROC CtrlPzBPres()
    IF NOT bDryRun THEN
      WaitDI diGrpBPartPres,1\MaxTime:=2;
    ENDIF
    !
    !ERROR
    !IF ERRNO=ERR_WAIT_MAXTIME THEN
    ! Set do_CustomErr;
    !SetGO go_ErrNo,1;
    !TRYNEXT;
    !
    !ENDIF
    !
  ENDPROC

  PROC CtrlPzANotPres()
    IF NOT bDryRun THEN
      WaitDI diGrpAPartPres,0\MaxTime:=2;
    ENDIF
    !
    ! ERROR
    ! IF ERRNO=ERR_WAIT_MAXTIME THEN
    !  Set do_CustomErr;
    ! SetGO go_ErrNo,1;
    !TRYNEXT;
    !
    !ENDIF
    !
  ENDPROC

  PROC CtrlPzBNotPres()
    IF NOT bDryRun THEN
      WaitDI diGrpBPartPres,0\MaxTime:=2;
    ENDIF
    !
    !ERROR
    !IF ERRNO=ERR_WAIT_MAXTIME THEN
    ! Set do_CustomErr;
    ! SetGO go_ErrNo,1;
    ! TRYNEXT;
    !
    ! ENDIF
    !
  ENDPROC

  !**********************************************************************
  !**********************************************************************
  !end
ENDMODULE
