!(import! &self ../../core/helper)
!(import! &self "../../core/helpers.py")
!(import! &self ../appraisal)

!(import! &self ../../core/state)
!(import! &self ../../category/functors)
!(import! &self ../appraisal_calculation)

(= (roundAppraisedWith
        $appraisal
        (motivation
            ($gInd $gTrans $gHelp $gCurio $gNovel $gSelf $gEthic $gSoc)
            ($valence $arousal $approach $resolution $threshold $securing)
        )
        (stimulus $novelty $conduciveness $risk $effort)
   )
    (let* (
        ($appraised
            (appraise
                $appraisal
                (motivation
                    ($gInd $gTrans $gHelp $gCurio $gNovel $gSelf $gEthic $gSoc)
                    ($valence $arousal $approach $resolution $threshold $securing)
                )
                (stimulus $novelty $conduciveness $risk $effort)
            )
        )
    )
        (let $appraised (motivation $goals ($valence2 $arousal2 $approach2 $resolution2 $threshold2 $securing2))
            (motivation
                $goals
                (
                    (eval (roundNum $valence2 6))
                    (eval (roundNum $arousal2 6))
                    (eval (roundNum $approach2 6))
                    (eval (roundNum $resolution2 6))
                    (eval (roundNum $threshold2 6))
                    (eval (roundNum $securing2 6))
                )
            )
        )
    )
)

(= (roundAppraisedState $state $stimulus)
    (roundAppraisedWith (openPsiAppraisal) $state $stimulus)
)

!(test
    (extract (openPsiAppraisal) (motivation (0.25 0.75 0.5 0.5 0.5 0.5 0.5 0.5) (0.125 0.25 0.375 0.5 0.625 0.75)))
    (motivation (0.25 0.75 0.5 0.5 0.5 0.5 0.5 0.5) (0.125 0.25 0.375 0.5 0.625 0.75))
)

!(test
    (roundAppraisedWith
        (openPsiAppraisalWith openPsiAppraise)
        (motivation (0.25 0.75 0.5 0.5 0.5 0.5 0.5 0.5) (0.125 0.25 0.375 0.5 0.625 0.75))
        (stimulus 0.125 0.25 0.125 0.0)
    )
    (motivation
        (0.25 0.75 0.5 0.5 0.5 0.5 0.5 0.5)
        (0.28585 0.452594 0.458358 0.65701 0.66917 0.756101)
    )
)

!(test
    (roundAppraisedState
        (motivation (0.25 0.75 0.5 0.5 0.5 0.5 0.5 0.5) (0.125 0.25 0.375 0.5 0.625 0.75))
        (stimulus 0.125 0.25 0.125 0.0)
    )
    (motivation
        (0.25 0.75 0.5 0.5 0.5 0.5 0.5 0.5)
        (0.28585 0.452594 0.458358 0.65701 0.66917 0.756101)
    )
)
