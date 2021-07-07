import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Listas {
    public static void main(String[] args) {
        String fich = "/home/morais/Downloads/srcr/lista.csv";
        String line = "";
        String split = ";";
        List<String> l = new ArrayList<>();
        int i;
        int distancia;
        try (BufferedReader buffer = new BufferedReader(new FileReader(fich))) {
            while ((line = buffer.readLine()) != null) {
                l.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<String[]> lista;
        lista = l.stream().map(x -> x.split(",")).collect(Collectors.toList());
        for(i=0;i<1561;i++) {
            System.out.println("arco(" + lista.get(i)[0] + "," + lista.get(i+1)[0] + "," + Math.sqrt(Math.pow((Double.parseDouble(lista.get(i)[1]) - Double.parseDouble(lista.get(i+1)[1])),2) + Math.pow((Double.parseDouble(lista.get(i)[2]) - Double.parseDouble(lista.get(i+1)[2])),2)) + ","  + lista.get(i)[7] + ")");
        }
    }

}
