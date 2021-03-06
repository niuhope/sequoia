!***********************************************************************
!                                    Version 0: 02/02 MKN              *
!                                                                      *
!    GETEDITS -  Called from Teton.cc to get current values for        *
!                various edits so that they can be printed             *
!                to the log file.                                      *
!                                                                      *
!    Input:   IterControls - structure of the iteration values for     *
!                            each type ( eg., temperature )            *
!             noutrt       - outer temperature iterations this cycle   *
!             ninrt        - outer intensity iterations this cycle     *
!             ngdart       - acceleration iterations this cycle.       *
!                                                                      *
!    Output:  noutrt, ninrt and ngdart.                                *
!                                                                      *
!***********************************************************************
   subroutine getEdits(IterControls, DtControls, RadEdit, &
                       noutrt, ninrt, ngdart, TrMaxZone,  &
                       TeMaxZone, TrMaxNode, TeMaxNode,   & 
                       dtrad, TrMax, TeMax, erad, emat,   &
                       eradinct, eradesct, eextsrc, echeck )

   use kind_mod
   use iter_control_list_mod
   use iter_control_mod
   use TimeStepControls_mod
   use Editor_mod

   implicit none


!  Arguments

   type(IterControlList)     :: IterControls
   type(TimeStepControls)    :: DtControls
   type(Editor)              :: RadEdit

   integer, intent(inout)    :: noutrt, ninrt, ngdart
   integer, dimension (1)    :: TrMaxZone, TeMaxZone
   integer, intent(inout)    :: TrMaxNode, TeMaxNode

   real(adqt), intent(inout) :: dtrad 
   real(adqt), intent(inout) :: TrMax, TeMax, erad, emat
   real(adqt), intent(inout) :: eradinct, eradesct, eextsrc, echeck

!  Local

   type(IterControl), pointer :: temperatureControl
   type(IterControl), pointer :: intensityControl
   type(IterControl), pointer :: accelerationControl

!  Iteration Controls

   temperatureControl  => getIterationControl(IterControls,"temperature")
   intensityControl    => getIterationControl(IterControls,"intensity")
   accelerationControl => getIterationControl(IterControls,"grey")

   noutrt = getNumberOfIterations(temperatureControl)
   ninrt  = getNumberOfIterations(intensityControl)
   ngdart = getNumberOfIterations(accelerationControl)

!  Time Step Controls

   dtrad  = getRadTimeStep(DtControls)

!  Energy and Temperature Edits

   TrMaxZone = getTrMaxZone(RadEdit)
   TeMaxZone = getTeMaxZone(RadEdit)
   TrMaxNode = getTrMaxNode(RadEdit)
   TeMaxNode = getTeMaxNode(RadEdit)
   TrMax     = getTrMax(RadEdit)
   TeMax     = getTeMax(RadEdit)
   erad      = getEnergyRadiation(RadEdit)
   emat      = getEnergyMaterial(RadEdit)
   eradinct  = getEnergyIncident(RadEdit)
   eradesct  = getEnergyEscaped(RadEdit)
   eextsrc   = getEnergyExtSources(RadEdit)
   echeck    = getEnergyCheck(RadEdit)


   return
   end subroutine getEdits



