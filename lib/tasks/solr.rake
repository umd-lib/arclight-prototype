SolrWrapper.default_instance_options = {
    verbose: true,
    port: '8983',
    version: '7.5.0',
    mirror_url: 'http://lib-solr-mirror.princeton.edu/dist/',
    solr_zip_path: '/home/arclight/dist/solr.zip',
    instance_dir: '/home/arclight/solr/instance',
    managed: true,
    persist: true,
    collection: {
      dir: 'solr/conf/',
      name: 'blacklight-core'
    }
}
require 'solr_wrapper/rake_task'