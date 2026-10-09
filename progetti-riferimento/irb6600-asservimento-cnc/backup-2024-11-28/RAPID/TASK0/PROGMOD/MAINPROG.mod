%%%
  VERSION:1
  LANGUAGE:ENGLISH
%%%

MODULE MAINPROG
  ![NFC 2023.05.23]
  LOCAL CONST string stModuleName:="MAINPROG";
  !
  PERS num nCurrentJob:=249;
  !PERS num nCurrentJobOpt:=0;
  PERS bool bBancoZone:=FALSE;
  PERS bool bInArea:=FALSE;
  PERS bool bInAreaPick:=FALSE;
  PERS bool bInAreaDrop:=FALSE;
  PERS num nPosPick:=8;
  PERS num nPosDrop:=17;

  !PERS num nPosDepOut:=1;
  !--------------------------------------------------------------
  ![Routine di Servizio Operatore (aaa)]
  ![...]
  ![...]
  PROC aaa_OpManuali()
    VAR num nFK;
    VAR num nTemp;
    VAR num nPage:=1;
    VAR string stPinza;
    VAR string stFileName;
    VAR string stModName;
    VAR bool bResult;

    ! ******************
    ! OPERAZIONI MANUALI
    ! ******************
    Init;
    !
    stFileName:="HOME:\\!mission\\"+fxPieceFileName(GInput(giNumModel))+".mod";
    stModName:=fxPieceFileName(GInput(giNumModel));
    nPage:=1;
    !Load\Dynamic,stFileName;
    LoadUpdate stFileName,stModName;
    WHILE TRUE DO
      nTemp:=0;
      !
lblSelMiss:
      TPErase;
      !PWrite "1234567890123456789012345678901234567890";
      TPWrite "OPERAZIONE MANUALE PEZZO: "+ValToStr(GInput(giNumModel));
      !PWrite "1234511234567890123112345112345678901234";
      TPWrite " ";
      TEST nPage
      CASE 1:
        TPWrite "01: PrelCarro1  [A] | 03: DepCNC [A]";
        TPWrite "02: PrelCarro2  [A] | 04: PrelCNC [B] ";
        TPWrite " ................. | .................";
      CASE 2:
        TPWrite "05: DepCarro1 [B] | 06: DepCarro2 [B]";
        TPWrite "07: DepOut  [B] | 08: DepIsp [B] ";
        TPWrite "................. | .................";
      CASE 3:
        TPWrite "09: PrelIsp [B]  | 10: DepMeasure [B]";
        TPWrite "11: PrelMeasure [B] | 12: Scarto [A]";
        TPWrite "................. | .................";
      CASE 4:
        TPWrite "................  | ................";
        TPWrite "250: Home         | 251: Manutenzione";
        TPWrite "252 FuoriLinea    | 998 Salva Modulo";
      ENDTEST
      TPReadFK nFK,"(Pag."+ValToStr(nPage)+"/4)","Sel","","","Pag <-","Pag ->";
      TEST nFK
      CASE 1:
        TPReadNum nTemp,"Selezionare";
        IF nTemp<>0 GOTO lblExecMiss;
      CASE 4:
        nPage:=nPage-1;
        IF nPage<1 nPage:=4;
      CASE 5:
        nPage:=nPage+1;
        IF nPage>4 nPage:=1;
      DEFAULT:
        nTemp:=0;
      ENDTEST
      !
      GOTO lblEnd;
lblExecMiss:
      TEST nTemp
      CASE 1,2,3,4,5,6,7,8,9,10,11,12:
        %fxMissionName(nTemp)%;
        !            CASE 131:
        !                nCurrentJobOpt:=1;
        !                %fxMissionName(11)%;
        !            CASE 132:
        !                nCurrentJobOpt:=2;
        !                %fxMissionName(11)%;
      CASE 250:
        !Ritorno in Home (routine in modulo principale)
        rAutoHome;
      CASE 251:
        rManutPos;
      CASE 252:
        rOffLinePos;
      CASE 998:
        Save stModName;
      ENDTEST
lblEnd:
    ENDWHILE
  ENDPROC

  !--------------------------------------------------------------
  ![...]
  ![...]
  ![...]
  PROC Init()
    VAR bool bOk;

    !
    AccSet 70,30;
    !Inizialize program
    nCurrentJob:=0;
    !nCurrentJobOpt:=0;
    !
    !Reset Errore
    Reset sdoError;
    !
    !Reset Output
    SetGO goEchoJob,0;
    SetGO goEchoModel,0;
    !SetGO goEchoJobOpt,0;
    !Set tutti i segnali fuori ingombro
    IF DOutput(doHomePos)=1 THEN
      Set doOutCnc;
    ENDIF
    Set doOutMisura;
    Set doOutIsp;
    Reset doManutPos;
    Reset doOutSide;
    Reset doReqCloseMorsa;
    Reset doReqOpenMorsa;
  ENDPROC

  !--------------------------------------------------------------
  ![...]
  ![...]
  ![...]
  PROC Main()
    VAR string stJob:="";
    VAR string stFileName;
    VAR string stModName;
    VAR string stRoutineName;
    VAR string stAckSignal;
    VAR bool bAbortCycle;
    VAR num nTemp;
    VAR bool bOk;

    Init;
    !
    stFileName:="HOME:\\!mission\\"+fxPieceFileName(GInput(giNumModel))+".mod";
    stModName:=fxPieceFileName(GInput(giNumModel));
    LoadUpdate stFileName,stModuleName;
    SetGO goEchoModel,giNumModel;
    WHILE TRUE DO
      !
      bAbortCycle:=FALSE;
      WHILE bAbortCycle=FALSE DO
        !
        ! Attesa missione da PLC
        WaitUntil diStartJob=1;
        nCurrentJob:=GInput(giNumJob);
        !nCurrentJobOpt:=GInput(giJobOption);
        !AppendToLog LOG_PRD,"giNumJob:"+ValToStr(nCurrentJob)+"|giJobOption:"+ValToStr(nCurrentJobOpt)+"|giPieceType:"+ValToStr(giNumModel)+"|giBinType:1";
        SetGO goEchoJob,nCurrentJob;
        !SetGO goEchoJobOpt,nCurrentJobOpt;
        !
        WaitUntil diStartJob=0;
        !
        ! Update moduli (se editati offline)
        stModName:=fxPieceFileName(GInput(giNumModel));
        stFileName:="HOME:\\!mission\\"+stModName+".mod";
        stRoutineName:=fxMissionName(nCurrentJob);
        bOk:=fxLoadUpdMod(stFileName,stModName);
        !
        ! Esecuzione missione
        TEST nCurrentJob
        CASE 1,2,3,4,5,6,7,8,9,10,11,12:
          %stRoutineName%;
        CASE 249:
          ! Stop Ciclo (routine in modulo principale)
          rEndCycle;
          bAbortCycle:=TRUE;
        CASE 250:
          !Ritorno in Home (routine in modulo principale)
          rAutoHome;
        CASE 251:
          !Posizione di Manutenzione (routine in modulo principale)
          rManutPos;
        CASE 252:
          !Posizione di Fuori Linea (routine in modulo principale)
          rOffLinePos;
        ENDTEST
        !
        ! Fine ciclo a PLC
        IF DOutput(doJobDone)=1 THEN
          Reset doJobDone;
          WaitTime 0.5;
        ENDIF
        Set doJobDone;
        WaitTime 0.5;
        Reset doJobDone;
        SetGO goEchoJob,0;
        !                SetGO goEchoJobOpt,0;
      ENDWHILE
      !
      !Stop a fine ciclo. Non rimuovere
      Stop;
    ENDWHILE
  ERROR
    Reset sdoError;
    PulseDO\High\PLength:=1,sdoError;
    TEST ERRNO
    CASE ERR_REFUNKPRC:
      TPErase;
      ErrWrite "ERROR!","Job inexistent!";
      PulseDO\High\PLength:=1,sdoError;
      TRYNEXT;
    DEFAULT:
      RAISE;
      Stop;
    ENDTEST
  ENDPROC

  !--------------------------------------------------------------
  ![...]
  ![...]
  ![...]
  PROC rEndCycle()
    rAutoHome;
  ENDPROC

  !--------------------------------------------------------------
  ![...]
  ![...]
  ![...]
  PROC rForceHomePos()
    !        MoveAbsJ jHomePos,v500,fine,tool0\WObj:=wobj0;
  ENDPROC

  !--------------------------------------------------------------
  ![...]
  ![...]
  ![...]
  PROC rAutoHome()
    !Return to home position..
    IF DOutput(doHomePos)=0 THEN
      ! -------------------------------------------
      IF GOutput(goEchoJob)=3 OR GOutput(goEchoJob)=4 THEN
        IF diSelMorsa=1 THEN
          IF diStCloseMorsa=1 AND diStOpenMorsa=0 THEN
            Set doReqGrpAOpen;
            WaitUntil diGrpAPartPres=0;
            Reset doReqGrpAOpen;
            GripLoad load0;
          ENDIF
        ENDIF
      ENDIF
      !Check_Home;
      MoveRec_Home;
    ENDIF
    MoveAbsJ jHomePos,v500,fine,tool0\WObj:=wobj0;
    PosRec_Clear;
    ! ------------------------------------------- 
  ENDPROC

  !    !--------------------------------------------------------------
  !    ![Posizione di manutenzione]
  !    ![...]
  !    ![...]
  PROC rManutPos()
    !
    ! Posizione di manutenzione;
    MoveAbsJ jFI_Manut,v500,fine,tool0\WObj:=wobj0;
    Set doManutPos;
  ENDPROC

  !    !--------------------------------------------------------------
  !    ![Posizione di "Fuori Linea"]
  !    ![...]
  !    ![...]
  PROC rOffLinePos()
    MoveAbsJ jFI_OffLine,v500,fine,tool0\WObj:=wobj0;
    Set doOutSide;
  ENDPROC

  !--------------------------------------------------------------
  ![Posizione di "Teach dei punti"]
  ![...]
  ![...]
  PROC rTeachPoints()
    ! ******************
    ! TEACH PUNTI
    ! ******************
    ! ATTENZIONE! Non eseguire.
    ! Questa routine è una routine di servizio
    ! utilizzata per apprendere i punti.
    Stop;
    !        MoveAbsJ jHomePos,v500,fine,tGripper\WObj:=wobj0;
    !        MoveAbsJ jFrntCassetto,v500,fine,tGripper\WObj:=wobj0;
    !        MoveAbsJ jFI_OffLine,v500,fine,tGripper\WObj:=wobj0;
    !        MoveAbsJ jFI_Manut,v500,fine,tGripper\WObj:=wobj0;
    !        MoveL pAutoHomeBin10,v1000,z100,tool0\WObj:=wobj0;
    !        MoveL pAutoHomeBin20,v1000,z100,tool0\WObj:=wobj0;
    !        MoveL pAutoHomeOut10,v1000,z100,tool0\WObj:=wobj0;
    !        MoveL pAutoHomeOut20,v1000,z100,tool0\WObj:=wobj0;
    !        MoveL pDepMaster,v1000,z100,tool0\WObj:=wobj0;
    !        MoveAbsJ jOverBinOut,v1000,z100,tool0\WObj:=wobj0;
    !        MoveAbsJ jFrntOutDep,v500,z100,tool0\WObj:=wobj0;
  ENDPROC
ENDMODULE
