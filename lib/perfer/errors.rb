module Perfer
  class Error < RuntimeError
  end

  module Errors
    MIX_BENCH_TYPES = "Cannot mix iterations and input size benchmarks in the same session"
    SAME_JOB_TITLES = "Multiple jobs with the same title are not allowed"
    WRONG_MEASURE_USE = "Cannot use Session#measure with an iteration job"
    WORKING_DIR_DIRTY = "The working directory is dirty, commit (or stash) your changes first"
  end
end
