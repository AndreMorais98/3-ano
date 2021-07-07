import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {

        String fich = "/home/morais/Downloads/srcr/paragem_autocarros_oeiras.csv";
        String line = "";
        String split = ";";

        try (BufferedReader buffer = new BufferedReader(new FileReader(fich))) {

            while ((line = buffer.readLine()) != null) {

                // use comma as separator
                String[] paragem = line.split(split);

                System.out.println("paragem(" + paragem[0]  + "," + paragem[1]  + "," + paragem[2]  + "," + "\"" + paragem[3] + "\""  + "," + "\"" +paragem[4] + "\""  + "," + "\"" + paragem[5] + "\""  + "," + "\"" +paragem[6] + "\""  + "," + "[" + paragem[7] + "]" + "," + paragem[8]  + "," + "\"" + paragem[9] + "\"" + "," + "\"" + paragem[10] + "\"" + ").");

            }

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
