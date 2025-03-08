resource "local_file" "productos" {
  count    = 5
  content  = "lista de productos"
  filename = "productos-${random_string.sufijo[count.index].id}.txt"
}
