module Linear

    class Matrix
        
        def self.row_matrix(elems_array)
            Matrix.new [elems_array]
        end

        def self.col_matrix(elems_array)
            Matrix.new elems_array.map { |e| [e] }
        end


        def initialize(elements)
            @elements = elements
        end

        def add_column(col_elem)
            raise "The dimension of the column does not match" unless col_elem.length == rows.length
            Matrix.new rows.zip(col_elem).map { |org_row, new_elem| org_row << new_elem}
        end

        def rows
            @elements
        end

        def columns
            rows.transpose
        end

        def shape
            [rows.length, columns.length]
        end

        def same_shape?(other)
            self.shape == other.shape
        end

        def transpose
            if rows.length == 1
                Matrix.col_matrix(rows[0])
            else
                Matrix.new rows.transpose
            end
        end

        def prettify
            header = "Matrix #{shape.first} x #{shape.last}"

            body = rows.reduce("") do |acc, row|
                acc + row.join("\t") + "\n"
            end

            header + "\n" + body
        end

        # n starts from 1
        def row(n)
            rows[n-1]
        end

        def column(n)
            columns[n-1]
        end


        def multiply_row(n, k)
            new_row = row(n).map { |e| e * k }
            rows[n-1].replace(new_row)
            Matrix.new rows
        end

        def add_rows(n1, k, n2)
            r1 = row(n1)
            r2 = row(n2)
            new_row = r1.zip(r2).map { |e1, e2| k * e1 + e2 }
            rows[n2-1].replace(new_row)
            Matrix.new rows
        end

        def swap_rows(n1, n2)
            r1 = row(n1)
            r2 = row(n2)
            rows[n1-1] = r2
            rows[n2-1] = r1
            Matrix.new rows
                
        end

        def scalar_multiply(k)
            new_rows = []

            rows.each do |row|
                new_rows << row.map { |e| e * k }
            end 

            Matrix.new new_rows
        end

        def add(other)
            raise "Only two matrics with the same shape can be added" unless same_shape?(other)

            new_rows = []

            rows.zip(other.rows) do |r1, r2|
                new_row = (r1.zip(r2).map { |e1, e2| e1 + e2 })
                new_rows << new_row
            end
            
            Matrix.new new_rows
        end

        def multiply(other)
            new_rows = []

            rows.each do |row1|
                new_row = [] 
                other.transpose.rows.each do |row2|
                     new_row << (row1.zip(row2).map { |e1, e2| e1 * e2 }).reduce(:+)
                end
                new_rows << new_row
            end

            Matrix.new new_rows
        end

    end


    class Square < Matrix

        def square?
            shape.first == shape.last
        end

        def power(k)
            result = self

            2.upto(k) do
                puts ("multiply")
                result = result.multiply(self)
            end
            
            result
        end
    end

end