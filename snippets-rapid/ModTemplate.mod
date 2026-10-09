MODULE ModTemplate
    !***********************************************************
    ! Modulo di esempio - struttura base
    !***********************************************************

    ! Dati del tool e del work object (da adattare alla cella)
    PERS tooldata tGripper := [TRUE,[[0,0,100],[1,0,0,0]],[1,[0,0,50],[1,0,0,0],0,0,0]];
    PERS wobjdata wobjTable := [FALSE,TRUE,"",[[500,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];

    ! Posizioni
    CONST robtarget pHome := [[300,0,400],[0,0,1,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget pPick := [[0,0,0],[0,0,1,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];

    ! Parametri
    CONST num nApproach := 100;

    PROC main()
        rInit;
        WHILE TRUE DO
            rPick;
        ENDWHILE
    ENDPROC

    PROC rInit()
        MoveJ pHome, v500, fine, tGripper \WObj:=wobj0;
    ENDPROC

    PROC rPick()
        MoveJ Offs(pPick, 0, 0, nApproach), v500, z50, tGripper \WObj:=wobjTable;
        MoveL pPick, v100, fine, tGripper \WObj:=wobjTable;
        ! Chiudi pinza qui (es. SetDO doGripper, 1;)
        WaitTime 0.5;
        MoveL Offs(pPick, 0, 0, nApproach), v200, z10, tGripper \WObj:=wobjTable;
    ERROR
        TPWrite "Errore in rPick: " \Num:=ERRNO;
        RAISE;
    ENDPROC
ENDMODULE
