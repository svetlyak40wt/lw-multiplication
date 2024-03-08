(defpackage #:multiplication-ci/ci
  (:use #:cl)
  (:import-from #:40ants-ci/jobs/docs
                #:build-docs)
  (:import-from #:40ants-ci/workflow
                #:defworkflow))
(in-package #:multiplication-ci/ci)


(defworkflow docs
  :on-push-to "master"
  :by-cron "0 10 * * 1"
  :cache t
  :jobs ((build-docs
          :asdf-system "multiplication-docs")))
