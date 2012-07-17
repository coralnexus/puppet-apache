
class apache::mod::ssl {
  include apache
  apache::module {'ssl': }
}
