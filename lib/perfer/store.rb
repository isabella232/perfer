module Perfer
  class Store
    attr_reader :file
    def initialize(file)
      @file = file
    end

    def self.for_session(session)
      path = DIR/'results'
      path.mkpath unless path.exist?

      bench_file = session.file

      # get the relative path to root, and relocate in @path
      names = bench_file.each_filename.to_a
      # prepend drive letter on Windows
      names.unshift bench_file.path[0..0].upcase if File.dirname('C:') == 'C:.'

      new path.join(*names).add_ext('.yml')
    end

    def delete
      @file.unlink
    end

    def yaml_load_documents
      docs = @file.open { |f| YAML.load_stream(f) }
      docs = docs.documents unless Array === docs
      docs
    end

    def load
      return unless @file.exist?
      yaml_load_documents
    end

    def append(result)
      @file.dir.mkpath unless @file.dir.exist?
      @file.append YAML.dump(result)
    end

    def save(results)
      @file.dir.mkpath unless @file.dir.exist?
      # ensure results are still ordered by :run_time
      results.sort_by! { |r| r[:run_time] }
      @file.write YAML.dump_stream(*results)
    end

    def rewrite
      save load
    end
  end
end
