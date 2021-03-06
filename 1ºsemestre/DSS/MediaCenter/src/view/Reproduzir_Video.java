package view;


import MVC.View;
import javax.swing.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.*;
import java.net.Socket;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author xaLuG
 */
public class Reproduzir_Video extends javax.swing.JFrame implements View {

    /**
     * Creates new form Reproduzir_Musica
     */
    public Reproduzir_Video(Socket s,String nome, View v) {
        this.socket=s;
        this.nome=nome;
        this.tabela=(Videos_Lista) v;
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel3 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTextArea1 = new javax.swing.JTextArea();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        PLAYBUTTON = new javax.swing.JButton();
        DOWNLOAD = new javax.swing.JButton();
        RemoveButton = new javax.swing.JButton();
        CategoriaChange = new javax.swing.JButton();
        Musica_field = new javax.swing.JFormattedTextField();

        jTextArea1.setColumns(20);
        jTextArea1.setRows(5);
        jScrollPane1.setViewportView(jTextArea1);

        String fich = this.nome + ".mp4";
        Musica_field.setText(fich);
        Musica_field.setEditable(false);

        setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent evt) {
                onExit();
            }
        });

        setSize(new java.awt.Dimension(450, 350));

        jLabel1.setIcon(new javax.swing.ImageIcon(System.getProperty("user.dir")+ File.separator
                +"src"+File.separator+"view"+File.separator+"icons"+File.separator+"mediacenter.png")); // NOI18N

        PLAYBUTTON.setForeground(new java.awt.Color(240, 240, 240));
        PLAYBUTTON.setIcon(new javax.swing.ImageIcon(System.getProperty("user.dir")+ File.separator
                +"src"+File.separator+"view"+File.separator+"icons"+File.separator+"reproduzir.png")); // NOI18N
        PLAYBUTTON.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                PLAYBUTTONActionPerformed(evt);
            }
        });

        DOWNLOAD.setIcon(new javax.swing.ImageIcon(System.getProperty("user.dir")+ File.separator
                +"src"+File.separator+"view"+File.separator+"icons"+File.separator+"download.png")); // NOI18N
        DOWNLOAD.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                DOWNLOADActionPerformed(evt);
            }
        });

        RemoveButton.setForeground(new java.awt.Color(240, 240, 240));
        RemoveButton.setIcon(new javax.swing.ImageIcon(System.getProperty("user.dir")+ File.separator
                +"src"+File.separator+"view"+File.separator+"icons"+File.separator+"delete.png")); // NOI18N
        RemoveButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                RemoveButtonActionPerformed(evt);
            }
        });

        CategoriaChange.setForeground(new java.awt.Color(240, 240, 240));
        CategoriaChange.setIcon(new javax.swing.ImageIcon(System.getProperty("user.dir")+ File.separator
                +"src"+File.separator+"view"+File.separator+"icons"+File.separator+"change.png")); // NOI18N
        CategoriaChange.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                CategoriaChangeActionPerformed(evt);
            }
        });

        Musica_field.setHorizontalAlignment(javax.swing.JTextField.CENTER);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
                layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                                .addGap(0, 0, Short.MAX_VALUE)
                                .addComponent(jLabel1)
                                .addGap(74, 74, 74))
                        .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                        .addGroup(layout.createSequentialGroup()
                                                .addGap(3, 3, 3)
                                                .addComponent(jLabel2))
                                        .addGroup(layout.createSequentialGroup()
                                                .addGap(35, 35, 35)
                                                .addComponent(Musica_field, javax.swing.GroupLayout.PREFERRED_SIZE, 359, javax.swing.GroupLayout.PREFERRED_SIZE))
                                        .addGroup(layout.createSequentialGroup()
                                                .addGap(122, 122, 122)
                                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                                        .addGroup(layout.createSequentialGroup()
                                                                .addComponent(PLAYBUTTON, javax.swing.GroupLayout.PREFERRED_SIZE, 80, javax.swing.GroupLayout.PREFERRED_SIZE)
                                                                .addGap(18, 18, 18)
                                                                .addComponent(DOWNLOAD, javax.swing.GroupLayout.PREFERRED_SIZE, 80, javax.swing.GroupLayout.PREFERRED_SIZE))
                                                        .addGroup(layout.createSequentialGroup()
                                                                .addComponent(RemoveButton, javax.swing.GroupLayout.PREFERRED_SIZE, 80, javax.swing.GroupLayout.PREFERRED_SIZE)
                                                                .addGap(18, 18, 18)
                                                                .addComponent(CategoriaChange, javax.swing.GroupLayout.PREFERRED_SIZE, 80, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                                .addContainerGap(39, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
                layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(layout.createSequentialGroup()
                                .addContainerGap()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                        .addComponent(jLabel1)
                                        .addComponent(jLabel2))
                                .addGap(34, 34, 34)
                                .addComponent(Musica_field, javax.swing.GroupLayout.PREFERRED_SIZE, 60, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(37, 37, 37)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                        .addComponent(PLAYBUTTON)
                                        .addComponent(DOWNLOAD))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                        .addComponent(RemoveButton)
                                        .addComponent(CategoriaChange))
                                .addContainerGap(31, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents


    public void onExit() {
        this.tabela.refresh();
    }

    private void PLAYBUTTONActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_PLAYBUTTONActionPerformed
        String name = this.nome;
        String ext = ".mp4";
        String fich = name + ext;
        try {
            PrintWriter pw = new PrintWriter(this.socket.getOutputStream());
            pw.println("reproduzirConteudo?" +fich);
            pw.flush();
            BufferedReader br = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
            int tam = Integer.parseInt(br.readLine());
            File newFile = File.createTempFile(name,ext);
            OutputStream out = new FileOutputStream(newFile);
            byte[] bytes = new byte[tam*2];
            InputStream in = socket.getInputStream();
            int count;
            int tcount=0;
            while (tcount<tam && (count = in.read(bytes)) > 0) {
                tcount+=count;
                out.write(bytes, 0, count);
            }
            out.flush();
            reproduzirConteudo(newFile.getName());
        }
        catch (IOException e){
            JOptionPane.showMessageDialog(this, "Erro de conex??o");
            return;
        }
    }//GEN-LAST:event_PLAYBUTTONActionPerformed


    public void reproduzirConteudo(String fich) {
        String path = System.getProperty("java.io.tmpdir")+File.separator+fich;
        ProcessBuilder pb = new ProcessBuilder(System.getProperty("user.dir")+File.separator+"dependencies"+File.separator+"VLC"+File.separator+"vlc.exe", path);
        try{
            pb.start();
        }
        catch (Exception e) {throw new NullPointerException(e.getMessage());}
    }

    private void DOWNLOADActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_DOWNLOADActionPerformed
        String fich = this.nome +".mp4";
        JFileChooser f = new JFileChooser();
        f.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        f.showSaveDialog(null);
        String path = f.getSelectedFile().getAbsolutePath();
        try{
            PrintWriter pw = new PrintWriter(this.socket.getOutputStream());
            pw.println("download?" +fich + "?" + path);
            pw.flush();
            BufferedReader br = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
            int tam = Integer.parseInt(br.readLine());
            if (tam==-1){
                JOptionPane.showMessageDialog(this, "N??o pode fazer download");
                return;
            }
            OutputStream out = new FileOutputStream(path+File.separator+fich);
            byte[] bytes = new byte[tam*2];
            InputStream in = socket.getInputStream();
            int count;
            int tcount=0;
            while (tcount<tam && (count = in.read(bytes)) > 0) {
                tcount+=count;
                out.write(bytes, 0, count);
            }
            out.flush();
            JOptionPane.showMessageDialog(this, "Download feito com sucesso");
        }
        catch (IOException e){
            JOptionPane.showMessageDialog(this, "Erro de conex??o");
        }
    }//GEN-LAST:event_DOWNLOADActionPerformed


    private void RemoveButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_RemoveButtonActionPerformed
        String fich = this.nome + ".mp4";
        try {
            PrintWriter pw = new PrintWriter(this.socket.getOutputStream());
            pw.println("removeConteudo?" +fich);
            pw.flush();
            BufferedReader br = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
            String res = br.readLine();
            if (!res.equals("Sucesso")){
                JOptionPane.showMessageDialog(this, res);
                return;
            }
            JOptionPane.showMessageDialog(this, "Conte??do removido com sucesso");
            this.tabela.refresh();
            dispose();
        }
        catch (IOException m){
            JOptionPane.showMessageDialog(this, "Erro de conex??o");
        }
    }//GEN-LAST:event_RemoveButtonActionPerformed

    private void CategoriaChangeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_CategoriaChangeActionPerformed
        new MudarCategoriaVideo(this.socket,this.nome,this.tabela).run();
        this.setVisible(false);
        dispose();
    }//GEN-LAST:event_CategoriaChangeActionPerformed


    public void run() {
        this.setLocationRelativeTo(null);
        this.setResizable(false);
        this.setSize(430,330);
        this.setVisible(true);
    }

    private Videos_Lista tabela;
    private String nome;
    private Socket socket;

    private javax.swing.JButton CategoriaChange;
    private javax.swing.JButton DOWNLOAD;
    private javax.swing.JFormattedTextField Musica_field;
    private javax.swing.JButton PLAYBUTTON;
    private javax.swing.JButton RemoveButton;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTextArea jTextArea1;
    // End of variables declaration//GEN-END:variables
}