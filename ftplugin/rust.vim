let b:ale_fixers = ['rustfmt']
let b:ale_linters = ['analyzer', 'cargo']

let b:ale_rust_cargo_check_examples = 1
let b:ale_rust_cargo_check_tests = 1
let b:ale_rust_cargo_use_clippy = executable('cargo-clippy')
