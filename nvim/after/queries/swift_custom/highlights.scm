; Keywords
[
	"associatedtype"
	"class"
;	"deinit"
	"enum"
	"extension"
	"fileprivate"
	"func"
	"import"
	"init"
	"inout"
	"internal"
	"let"
	"open"
	"operator"
	"private"
	"protocol"
	"public"
	"rethrows"
	"static"
	"struct"
	"subscript"
	"typealias"
	"var"
	"break"
	"case"
	"continue"
	"default"
	"defer"
	"do"
	"else"
;	"fallthrough"
	"for"
	"guard"
	"if"
	"in"
	"repeat"
	"return"
	"switch"
	"where"
	"while"
	"as"
;	"Any"
	"catch"
	"false"
	"is"
;	"nil"
;	"super"
	"self"
;	"Self"
	"throw"
	"throws"
	"true"
	"try"
	"associativity"
	"convenience"
	"dynamic"
	"didSet"
	"final"
	"get"
	"infix"
	"indirect"
	"lazy"
	"left"
	"mutating"
	"none"
	"nonmutating"
	"optional"
	"override"
	"postfix"
;	"precedence"
	"prefix"
	"Protocol"
	"required"
	"right"
	"set"
	"Type"
	"unowned"
	"weak"
	"willSet"
] @keyword

;[
;  "-"
;  "-="
;  "!"
;  "!="
;  "..."
;  "*"
;  "*="
;  "/"
;  "/="
;  "&"
;  "&&"
;  "&="
;  "%"
;  "%="
;  "^"
;  "^="
;  "+"
;  "++"
;  "+="
;  "<"
;  "<<"
;  "<="
;  "="
;  "=="
;  ">"
;  ">="
;  ">>"
;  "|"
;  "|="
;  "||"
;] @operator

(comment) @comment
(identifier) @identifier

; Types
(type_identifier) @type
(number) @number
(string_literal) @string
(nil_literal) @constant.builtin
(operator) @operator
(any_type) @type
(self_type) @variable
(identifier) @variable

; Attributes
(attribute) @attribute
(attribute_name) @type

(import_declaration identifier: (identifier) @keyword)

(variable_declaration var_name: (identifier) @variable)


; Structs
;(struct_declaration struct_name: (type_identifier) @keyword)
