package material

// Material represents a material properties
type Material struct {
	Name string             `json:"name"`
	R    map[string]float64 `json:"r"` // FIXME: the numer is always 0 .....
}
