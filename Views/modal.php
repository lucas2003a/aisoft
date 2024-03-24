<div class="modal-project">
        <div class="modal-form">
            <div class="modal-content">
                <div class="modal-title">
                    <div class="modal-head">
                        <div>
                            <button class="close"><strong>X</strong></button>
                        </div>
                        Mantenimiento
                        <hr>
                    </div>
                </div>
                <div class="modal-body">
                    <form action="">
                        <div class="form-group">
                            <label for="in-imagen" class="label-img">
                                <i class="material-icons"></i>
                                <span class="title">Agregar imagen</span>
                                <input type="file" accept=".jpg" id="in-imagen">
                            </label>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <input type="text" id="in-codigo" class="input-form-modal"  placeholder="Ingrese el código del proyecto" autofocus>
                            </div>
                            <div class="col-md-8">
                                <input type="text" id="in-denominacion" class="input-form-modal"  placeholder="Ingrese la denominaciòn" autofocus>
                            </div>
                        </div>
                        <div>
                            <select name="" id="in-direccion" class="input-form-modal">
                                <option value="0">Direccion sede</option>
                            </select>                                            
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" id="in-latitud" class="input-form-modal"  placeholder="Coordenadas de latitud" autofocus>
                            </div>
                            <div class="col-md-6">
                                <input type="text" id="in-longitud" class="input-form-modal"  placeholder="Coordenadas longitud" autofocus>
                            </div>
                        </div>
                        <div>
                            <input type="text" id="in-perimetro" class="input-form-modal"  placeholder="Ingrese el perímetro (JSON)" autofocus>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <select name="" id="in-departamento" class="input-form-modal">
                                    <option value="0">Departamento</option>
                                </select>                                            
                            </div>
                            <div class="col-md-4">
                                <select name="" id="in-provincia" class="input-form-modal">
                                    <option value="0">Provincia</option>
                                </select>                                            
                            </div>
                            <div class="col-md-4">
                                <select name="" id="in-distrito" class="input-form-modal">
                                    <option value="0">Distrito</option>
                                </select>                                            
                            </div>
                        </div>
                        <div>
                            <input type="text" id="in-direccion" class="input-form-modal"  placeholder="Ingrese la direcciòn" autofocus>
                        </div>
                        <div>
                            <input type="text" id="in-idusuario" class="input-form-modal"  placeholder="idusuario" autofocus>
                        </div>
                    </form>
                </div>
                <hr>
                <div class="modal-footer">
                    <button class="btn-guardar" id="guardar">Guardar</button>
                    <button class="btn-cerrar" id="cerrar">Cerrar</button>
                </div>
            </div>
        </div>
    </div>


    <script>
        
        $("#card-project").addEventListener("click",(e)=>{

            if(e.target.classList.contains("editar")){

                //console.log(e);
                console.log("Edita");

                $(".modal-form").classList.toggle("show");

            }

        });

        $("#cerrar").addEventListener("click", ()=>{

            $(".modal-project").classList.remove("show");

        });
    </script>